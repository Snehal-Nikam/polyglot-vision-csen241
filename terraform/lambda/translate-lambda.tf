data archive_file translate-lambda {
  type        = "zip"
  source_file = "${path.root}/../lambda/translate.py"
  output_path = "translate-lambda.zip"
}

resource "aws_lambda_function" "translate-lambda" {
  function_name = "translate-lambda"
  role          = module.security.translate-lambda-role
  filename      = data.archive_file.translate-lambda.output_path
  runtime       = "python3.8"
  handler       = "translate.lambda_handler"
  environment {
    variables = {
      "TRANSLATE_BUCKET" = module.s3.polyglot-translation-bucket
    }
  }
}

resource "aws_lambda_permission" "allow_bucket_translation_translate" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.translate-lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${module.s3.polyglot-transcribe-output-bucket}"
}

resource "aws_s3_bucket_notification" "bucket_notification_translate-lambda" {
  bucket = module.s3.polyglot-transcribe-output-bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.subtitles-lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".json"
  }
  depends_on = [aws_lambda_function.translate-lambda, aws_lambda_permission.allow_bucket_translation_translate]
}

