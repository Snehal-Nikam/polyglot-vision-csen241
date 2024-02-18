import json
import os
from urllib import request

VIDEO_BUCKET = os.getenv('VIDEO_BUCKET')
TRANSLATE_BUCKET = os.getenv('TRANSLATE_BUCKET')
SUBTITLE_API = os.getenv('SUBTITLE_API')

def construct_paths(video_id):
    return {
        'original_video': f'{VIDEO_BUCKET}/original-video/{video_id}.mp4',
        'transcription': f'{TRANSLATE_BUCKET}/language-english/{video_id}.vtt',
        'translation': f'{TRANSLATE_BUCKET}/language-hindi/{video_id}.vtt',
        'subtitled_video': f'{VIDEO_BUCKET}/subtitled-video/{video_id}.mp4',
        'job_info': f'{VIDEO_BUCKET}/info/{video_id}.json'
    }

def send_caption_request(data):
    url = f'http://{SUBTITLE_API}:8080/video'
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

    record = event