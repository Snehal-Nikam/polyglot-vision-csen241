import logging
import boto3
from boto3.dynamodb.conditions import Key
from botocore.exceptions import ClientError

# This function scans a DynamoDB table and retrieves all items.
def retrieve_all_records(table_name):
   
    dynamo_client = boto3.client('dynamodb', region_name='us-west-2')
    try:
        response = dynamo_client.scan(
            TableName=table_name,
            Select='ALL_ATTRIBUTES'
        )
        return response['Items']
    except ClientError as exc:
        logging.error(exc)
        return False

# This function retrieves all items from a DynamoDB table where a specified key has a specified value
def get_records_by_key(table_name, key, value):
    
    dynamodb = boto3.resource('dynamodb', region_name='us-west-2')
    table = dynamodb.Table(table_name)
    try:
        response = table.scan(
            FilterExpression=Key(key).eq(value)
        )
        return response['Items']
    except ClientError as exc:
        logging.error(exc)
        return False

# This function saves an item to a DynamoDB table.
def save_record_to_dynamodb(table_name, record, key, value):
    
    dynamo_client = boto3.client('dynamodb', region_name='us-west-2')
    try:
        dynamo_client.put_item(
            TableName=table_name,
            Item=record,
        )
        new_record = dynamo_client.get_item(
            TableName=table_name,
            Key={key: value}
        )['Item']
        return new_record
    except ClientError as exc:
        logging.error(exc)
        return False
