import json
import os
from urllib import request

VIDEOS_BUCKET = os.getenv('VIDEOS_BUCKET')
TRANSLATE_BUCKET = os.getenv('TRANSLATE_BUCKET')
SUBTITLE_API = os.getenv('SUBTITLE_API')

def construct_paths(video_id):
    return {
        'original_video': f'{VIDEOS_BUCKET}/original/{video_id}.mp4',
        'transcription': f'{TRANSLATE_BUCKET}/language-english/{video_id}.vtt',
        'translation': f'{TRANSLATE_BUCKET}/language-hindi/{video_id}.vtt',
        'subtitled_video': f'{VIDEOS_BUCKET}/subtitled-video/{video_id}.mp4',
        'job_info': f'{VIDEOS_BUCKET}/info/{video_id}.json'
    }

def send_subtitle_request(data):
    url = f'{SUBTITLE_API}/video'
    headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'Content-Length': str(len(data))
    }
    request_data = json.dumps(data).encode('utf-8')
    req = request.Request(url, data=request_data, headers=headers)
    return request.urlopen(req)

def lambda_handler(event, context):
    if not event:
        return {
            'statusCode': 200,
            'body': json.dumps('No event data available.')
        }

    record = event['Records'][0]['s3']
    bucket = record['bucket']['name']
    key = record['object']['key']
    base_file_name = os.path.splitext(os.path.basename(key))[0]
    # video_id = base_file_name.replace('-hi', '')

    paths = construct_paths(base_file_name)
    response = send_subtitle_request(paths)

    return {
        'statusCode': response.getcode(),
        'body': response.read().decode('utf-8')
    }
    