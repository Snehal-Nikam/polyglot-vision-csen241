module "security" {
  source = "../security"
}

module "s3" {
  source = "../s3"
}

data archive_file transcribe-lambda {
  type        = "zip"
  source_file = "${path.root}/../lambda/transcribe.py"
  output_path = "transcribe-lambda.zip"
}

resource "aws_lambda_function" "transcribe-lambda" {
  function_name = "transcribe-lambda"
  role          = module.security.transcribe-lambda-role
  filename      = data.archive_file.transcribe-lambda.output_path
  runtime       = "python3.8"
  handler       = "transcribe.lambda_handler"
  environment {
    variables = {
      "TRANSCRIBE_BUCKET" = module.s3.polyglot-transcribe-output-bucket
    }
  }
  depends_on = [module.security]
}

#trigger for lambda
resource "aws_lambda_permission" "allow_bucket_input_transcribe" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.transcribe-lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${module.s3.polyglot-input-videos-bucket}"
  depends_on = [aws_lambda_function.transcribe-lambda]
}

resource "aws_s3_bucket_notification" "bucket_notification-transcribe-lambda" {
  bucket = module.s3.polyglot-input-videos-bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.transcribe-lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "original-video/"
    filter_suffix       = ".mp4"
  }
  depends_on = [aws_lambda_function.transcribe-lambda, aws_lambda_permission.allow_bucket_input_transcribe]
}

