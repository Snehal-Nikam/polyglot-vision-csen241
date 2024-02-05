output "role1_arn" {
  value = aws_iam_role.role1-s3Full-congitoReadOnly.arn
}

output "role2_arn" {
  value = aws_iam_role.role2-s3Full.arn
}