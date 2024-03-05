module "dynamodb" {
  source = "../dynamodb"
}

data archive_file final-lambda {
  type        = "zip"
  source_file = "${path.root}/../lambda/final.py"
  output_path = "final-lambda.zip"
}

resource "aws_lambda_function" "final-lambda" {
  function_name = "final-lambda"
  role          = module.security.final-lambda-role
  filename      = data.archive_file.final-lambda.output_path
  runtime       = "python3.8"
  handler       = "final.lambda_handler"
  environment {
    variables = {
      "SOURCE_EMAIL" = "user@polygloyvision.online" #Needs to be updated
      "VIDEOS_TABLE" = module.dynamodb.videos-info
    }
  }
  depends_on = [module.security]
}

#trigger for lambda
resource "aws_lambda_permission" "allow_bucket_input_final" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.final-lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${module.s3.polyglot-input-videos-bucket}"
  depends_on = [aws_lambda_function.final-lambda]
}

resource "aws_s3_bucket_notification" "bucket_notification-final-lambda" {
  bucket = module.s3.polyglot-input-videos-bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.final-lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "info/"
    filter_suffix       = ".json"
  }
  depends_on = [aws_lambda_function.final-lambda, aws_lambda_permission.allow_bucket_input_final]
}
