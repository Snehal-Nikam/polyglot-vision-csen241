import json
import os
import boto3

VIDEOS_TABLE = os.environ.get('VIDEOS_TABLE')
SOURCE_EMAIL = os.environ.get('SOURCE_EMAIL')


def create_object_url(bucket_name, file_name):
    return f'https://{bucket_name}.s3.amazonaws.com/{file_name}'


def get_video_info_from_s3(event, s3_client):
    file_obj = event['Records'][0]
    bucket_name = str(file_obj['s3']['bucket']['name'])
    file_name = str(file_obj['s3']['object']['key'])
    content_object = s3_client.Object(bucket_name, file_name)
    file_content = content_object.get()['Body'].read().decode('utf-8')
    return file_content, bucket_name, file_name


def update_video_info_in_dynamo(video_id, video_uri, info, dynamo_client):
    print("Uploading the item in db.....")
    updated_video = dynamo_client.update_item(
        TableName=VIDEOS_TABLE,
        Key={"video_id": {"S": video_id}},
        UpdateExpression='SET #U = :u, #D = :d, #T1 = :t1, #T2 = :t2, #F = :f',
        ExpressionAttributeValues={
            ":u": {"S": str(video_uri)},
            ":d": {"N": str(info['duration'])},
            ":t1": {"N": str(info['transcriptionWords'])},
            ":t2": {"N": str(info['translationWords'])},
            ':f': {"BOOL": True}
        },
        ExpressionAttributeNames={
            '#U': 'video_uri',
            '#D': 'duration',
            '#T1': 'transcription_words',
            '#T2': 'translation_words',
            '#F': 'finished',
        },
        ReturnValues='ALL_NEW'
    )['Attributes']
    return updated_video


def send_translation_notification(video_name, to_email, ses_client):
    message = f'The video {video_name} has been translated!'
    try:
        ses_client.send_email(
            Source=SOURCE_EMAIL,
            Destination={'ToAddresses': [to_email]},
            Message={
                'Subject': {'Data': 'Video Translated by Polyglot Vision'},
                'Body': {'Text': {'Data': message}}
            }
        )
    except ses_client.exceptions.MessageRejected:
        ses_client.verify_email_identity(EmailAddress=to_email)


def lambda_handler(event, context):
    s3_client = boto3.resource('s3')
    dynamo_client = boto3.client('dynamodb')
    ses_client = boto3.client('ses')

    if event:
        file_content, bucket_name, file_name = get_video_info_from_s3(event, s3_client)
        info = json.loads(file_content)
        video_id = info['video_id']
        video_key = f'/subtitled-video/{video_id}.mp4'
        video_uri = create_object_url(bucket_name, video_key)
        print("Uploading video info into dynamo db....", video_id)
        updated_video = update_video_info_in_dynamo(video_id, video_uri, info, dynamo_client)
        video_name = updated_video['video_name']['S']
        to_email = updated_video['user_email']['S']
        print("Sending email to user....")

        send_translation_notification(video_name, to_email, ses_client)

    return {'statusCode': 200, 'body': json.dumps('Final Lambda Job Successful!')}