import logging
import boto3
import hashlib
import time


def upload_to_s3(user_id, file_name, file_stream, s3_bucket, prefix=None):
   
    if prefix is None:
        prefix = ''
    try:

        file_id = hashlib.sha1(
            str.encode(user_id + file_name + str(time.time()))
        ).hexdigest()
        
        # building s3 key
        s3_key = f'{prefix}/{file_id}.mp4'

        # upload the file to s3
        s3_client = boto3.client('s3', region_name='us-east-1')
        s3_client.upload_fileobj(file_stream, s3_bucket, s3_key)
        
        return file_id
    
    except s3_client.exceptions.ClientError as exc:
        logging.error(f"Failed to upload file: {exc}")
        return False