import json
import os
import boto3

TRANSLATION_BUCKET = os.getenv('TRANSLATE_BUCKET')

def split_into_chunks(text, max_length=4500):
    lines = text.split('\n')
    chunk = ''
    chunks = []
    for i in range(0, len(lines), 4):
        chunk += '\n' + '\n'.join(lines[i:i+4])
        if len(chunk) > max_length:
            chunks.append(chunk)
            chunk = ''
    if chunk:
        chunks.append(chunk)
    return chunks

def format_time(seconds):
    milliseconds = int(seconds % 1 * 1000)
    total_seconds = int(seconds)
    seconds = int((total_seconds / 60) % 1 * 60)
    minutes = int(total_seconds / 60) % 60
    hours = int(total_seconds / 3600)
    return f"{hours:02d}:{minutes:02d}:{seconds:02d},{milliseconds:03d}"

def convert_json_to_vtt(transcription_json):
    entries = []
    current_sentence = []
    start_times = []
    end_times = []
    index = 1
    for item in transcription_json['results']['items']:
        if item['type'] == 'pronunciation':
            start_times.append(item['start_time'])
            end_times.append(item['end_time'])
            current_sentence.append(item['alternatives'][0]['content'])
        elif item['type'] == 'punctuation':
            current_sentence.append(item['alternatives'][0]['content'])
            if item['alternatives'][0]['content'] in ['.', '?', '!']:
                entries.append({
                    'index': index,
                    'start_time': format_time(float(start_times[0])),
                    'end_time': format_time(float(end_times[-1])),
                    'sentence': ' '.join(current_sentence)
                })
                current_sentence = []
                start_times = []
                end_times = []
                index += 1
    vtt_content = '\n'.join(
        f"{entry['index']}\n{entry['start_time']} --> {entry['end_time']}\n{entry['sentence']}\n"
        for entry in entries
    ).strip()
    return vtt_content

def correct_timestamp_format(line):
    if ' —> ' not in line:
        return line
    parts = line.split()
    return ''.join(parts[:2]) + ' --> ' + ''.join(parts[-2:])

def lambda_handler(event, _):
    s3_resource = boto3.resource('s3')
    translate_client = boto3.client('translate')

    if event:
        record = event['Records'][0]['s3']
        bucket = record['bucket']['name']
        key = record['object']['key']

        content = s3_resource.Object(bucket, key).get()['Body'].read().decode('utf-8')
        transcription = json.loads(content)
        vtt_content = convert_json_to_vtt(transcription)

        translated_chunks = []
        for chunk in split_into_chunks(vtt_content):
            print('Translating chunk')
            result = translate_client.translate_text(
                Text=chunk,
                SourceLanguageCode='en',
                TargetLanguageCode='hi'
            )
            translated_chunks.append(result['TranslatedText'])
        translated_chunks = '\n'.join(translated_chunks)
        translated_chunks = translated_chunks.strip().split('\n')
        translated_chunks = '\n'.join([correct_timestamp_format(l) for l in translated_chunks])

        base_file_name = os.path.splitext(os.path.basename(key))[0]

        s3_resource.Object(TRANSLATION_BUCKET, f'language-english/{base_file_name}.vtt').put(Body=vtt_content)
        s3_resource.Object(TRANSLATION_BUCKET, f'language-hindi/{base_file_name}.vtt').put(Body=translated_chunks)

    return {
        'statusCode': 200,
        'body': json.dumps('Translation Lambda completed successfully!')
    }