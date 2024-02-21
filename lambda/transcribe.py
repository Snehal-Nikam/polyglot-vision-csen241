import json
import os
import boto3

TRANSCRIBE_BUCKET = os.environ.get('TRANSCRIBE_BUCKET')


def create_uri(bucket_name, file_name):
    uri = 's3://{}/{}'.format(bucket_name, file_name)
    print(f"returning uri {uri}")
    return 's3://{}/{}'.format(bucket_name, file_name)


def lambda_handler(event, context):
    transcribe = boto3.client('transcribe')

    if 'Records' in event:
        file_obj = event['Records'][0]
        bucket_name = str(file_obj['s3']['bucket']['name'])
        file_name = str(file_obj['s3']['object']['key'])
        s3_uri = create_uri(bucket_name, file_name)

        _, file_name = os.path.split(file_name)
        file_name, file_ext = os.path.splitext(file_name)
        file_ext = file_ext[1:]

        print('started transcription for {}'.format(file_name))
        transcribe.start_transcription_job(
            TranscriptionJobName=file_name,
            LanguageCode='en-US',
            MediaFormat=file_ext,
            Media={
                'MediaFileUri': s3_uri
            },
            OutputBucketName=TRANSCRIBE_BUCKET
        )
    else:
        bucket_name = event['bucket']
        folder_name = event['folder']
        s3 = boto3.resource('s3')
        bucket = s3.Bucket(bucket_name)
        for obj in bucket.objects.filter(Prefix=folder_name):
            if obj.key.endswith(('.mp4', '.flac', '.wav', '.mp3')):
                print('started transcription for {}'.format(obj.key))
                transcribe.start_transcription_job(
                    TranscriptionJobName=obj.key,
                    LanguageCode='en-US',
                    MediaFormat=obj.key.split('.')[-1],
                    Media={
                        'MediaFileUri': 's3://{}/{}'.format(bucket_name, obj.key)
                    },
                    OutputBucketName=TRANSCRIBE_BUCKET
                )
    return {
        'statusCode': 200,
        'body': json.dumps('Transcribe job started!')
    }