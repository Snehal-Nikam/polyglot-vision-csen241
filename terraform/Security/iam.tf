data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
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

resource "aws_iam_policy" "subtitle-api-role-policy" {
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

resource "aws_iam_role_policy_attachment" "backend-role-policy-attachment" {
  role       = aws_iam_role.backend-role.name
  policy_arn = aws_iam_policy.policy-backend-role.arn
}

resource "aws_iam_role_policy_attachment" "subtitle-api-role-policy-attachment" {
  role       = aws_iam_role.subtitle-api-role.name
  policy_arn = aws_iam_policy.subtitle-api-role-policy.arn
}
