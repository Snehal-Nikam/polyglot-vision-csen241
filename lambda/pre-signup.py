def lambda_handler(event, context):
    try:
        user_attributes = event['request']['userAttributes']
        if user_attributes.get('email', ''):
            event['response']['autoConfirmUser'] = True  # Auto-confirm the user

        return event
    except Exception as e:
        print(f"Error handling pre-signup event: {e}")
        raise e
