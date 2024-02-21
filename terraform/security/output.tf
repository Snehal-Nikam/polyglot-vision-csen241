output "beckend-role" {
  value = aws_iam_role.backend-role.arn
}

output "subtitle-api-role" {
  value = aws_iam_role.subtitle-api-role.arn
}

output "transcribe-lambda-role" {
  value = aws_iam_role.transcribe-lambda-role.arn
}

output "translate-lambda-role" {
  value = aws_iam_role.translate-lambda-role.arn
}

output "subtitle-lambda-role" {
  value = aws_iam_role.subtitles-lambda-role.arn
}

output "lambda-subtitle-sg" {
  value = aws_security_group.lambda-subtitle-sg.arn
}

output "backend-sg" {
  value = aws_security_group.backend-sg.arn
}

output "subtitle-api-sg" {
  value = aws_security_group.subtitle-api-sg.arn
}

output "frontend-sg" {
  value = aws_security_group.frontend-sg.arn
}
