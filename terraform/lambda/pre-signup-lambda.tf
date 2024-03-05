data archive_file pre-signup-lambda {
  type        = "zip"
  source_file = "${path.root}/../lambda/pre-signup.py"
  output_path = "pre-signup-lambda.zip"
}

resource "aws_lambda_function" "pre-signup-lambda" {
  function_name = "pre-signup-lambda"
  role          = module.security.pre-signup-lambda-role
  filename      = data.archive_file.pre-signup-lambda.output_path
  runtime       = "python3.8"
  handler       = "pre-signup.lambda_handler"
  depends_on = [module.security]
}

module "cognito" {
  source = "../cognito"
  CALLBACK_URLS                 = ["https://app.polyglotvision.online"]
  LOGOUT_URLS                   = ["https://app.polyglotvision.online"]
  COGNITO_USER_POOL_CLIENT_NAME = "Polyglot"
  COGNITO_USER_POOL_NAME        = "Polyglot"
  ACCOUNT_ID = "992382695519" #TODO : Sourabh's AWS account ID
  AUTO_APPROVE_LAMBDA = "pre-signup-lambda"
  depends_on = [aws_lambda_function.pre-signup-lambda]
}

resource "aws_lambda_permission" "pre-signup-lambda-permission" {
  statement_id  = "AllowExecutionFromCognito"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.pre-signup-lambda.arn
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = module.cognito.COGNITO_USER_POOL_ARN
  depends_on = [module.cognito]
}