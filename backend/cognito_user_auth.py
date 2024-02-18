import boto3


cognito = boto3.client('cognito-idp', region_name='us-west-2')

def is_valid_user(user_pool, user_id):
    try:
        cognito.admin_get_user(
            UserPoolId=user_pool,
            Username=user_id
        )
        return True
    except cognito.exceptions.UserNotFoundException:
        return False
