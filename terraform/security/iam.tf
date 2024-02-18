data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com","lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda-role" {
  name               = "lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
resource "aws_iam_role" "backend-role" {
  name               = "backend-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
resource "aws_iam_role" "subtitle-api-role" {
  name               = "subtitle-api-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_policy" "policy-backend-role" {
  name        = "policy-backend-role"
  description = "A policy for backend-role"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:*",
          "cognito-idp:ListUsers",
          "cognito-idp:DescribeUserPool"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  })

}
resource "aws_iam_policy" "policy-subtitle-api-role" {
  name        = "policy2-s3Full"
  description = "A policy for subtitle-api-role"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  })
}
resource "aws_iam_policy" "policy-lambda-role" {
  name        = "policy-lambda-role"
  description = "A policy for lambda-role"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:*",
          "transcribe:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  })

}

resource "aws_iam_role_policy_attachment" "attachment-backend-role-policy" {
  role       = aws_iam_role.backend-role.name
  policy_arn = aws_iam_policy.policy-backend-role.arn
}
resource "aws_iam_role_policy_attachment" "attachment-subtitle-api-role-policy" {
  role       = aws_iam_role.subtitle-api-role.name
  policy_arn = aws_iam_policy.policy-subtitle-api-role.arn
}
resource "aws_iam_role_policy_attachment" "attachment-lambda-policy" {
  role       = aws_iam_role.lambda-role.name
  policy_arn = aws_iam_policy.policy-lambda-role.arn
}