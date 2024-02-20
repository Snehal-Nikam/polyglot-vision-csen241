output "subtitles-lambda-arn" {
  value = aws_lambda_function.subtitles-lambda.arn
}

output "transcribe-lambda-arn" {
  value = aws_lambda_function.transcribe-lambda.arn
}

output "translate-lambda-arn" {
  value = aws_lambda_function.translate-lambda.arn
}