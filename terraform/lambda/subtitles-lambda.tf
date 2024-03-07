data archive_file subtitles-lambda {
  type        = "zip"
  source_file = "${path.root}/../lambda/subtitles.py"
  output_path = "subtitles-lambda.zip"
}

resource "aws_lambda_function" "subtitles-lambda" {
  function_name = "subtitles-lambda"
  role          = module.security.subtitle-lambda-role
  filename      = data.archive_file.subtitles-lambda.output_path
  runtime       = "python3.8"
  handler       = "subtitles.lambda_handler"
  depends_on = [module.security]
  environment {
    variables = {
      "TRANSLATE_BUCKET" = module.s3.polyglot-translation-bucket,
      "VIDEOS_BUCKET"    = module.s3.polyglot-input-videos-bucket,
      "SUBTITLE_API"     = "https://app.polyglotvision.online"
    }
  }
}

resource "aws_lambda_permission" "allow_bucket_translation_subtitle" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.subtitles-lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${module.s3.polyglot-translation-bucket}"
  depends_on = [aws_lambda_function.subtitles-lambda, module.s3]
}

resource "aws_s3_bucket_notification" "bucket_notification_subtitles-lambda" {
  bucket = module.s3.polyglot-translation-bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.subtitles-lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "language-spanish/"
    filter_suffix       = ".vtt "
  }
  depends_on = [aws_lambda_function.subtitles-lambda, aws_lambda_permission.allow_bucket_translation_subtitle]
}

