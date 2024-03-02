output "COGNITO_USER_POOL_NAME" {
  value = aws_cognito_user_pool.polyglot.id
}

output "COGNITO_USER_POOL_CLIENT_NAME" {
    value = aws_cognito_user_pool_client.polyglot.id
}

output "COGNITO_USER_POOL_ARN" {
  value = aws_cognito_user_pool.polyglot.arn
}
