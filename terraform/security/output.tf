output "beckend-role" {
  value = aws_iam_role.backend-role.arn
}

output "subtitle-api-role" {
  value = aws_iam_role.subtitle-api-role.arn
}

output "lambda-role" {
  value = aws_iam_role.lambda-role.arn
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
