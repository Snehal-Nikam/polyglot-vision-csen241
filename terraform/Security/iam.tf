data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role1-s3Full-congitoReadOnly" {
  name               = "role1-s3Full-congitoReadOnly"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role" "role2-s3Full" {
  name               = "role2-s3Full"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_policy" "policy1-s3Full-cognitoReadOnly" {
  name        = "policy1-s3Full-cognitoReadOnly"
  description = "A policy for role1-s3Full-cognitoReadOnly"
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

resource "aws_iam_policy" "policy2-s3Full" {
  name        = "policy2-s3Full"
  description = "A policy for role2-s3Full"
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

resource "aws_iam_role_policy_attachment" "role1-s3Full-congitoReadOnly-policy-attachment" {
  role       = aws_iam_role.role1-s3Full-congitoReadOnly.name
  policy_arn = aws_iam_policy.policy1-s3Full-cognitoReadOnly.arn
}

resource "aws_iam_role_policy_attachment" "role2-s3Full-policy-attachment" {
  role       = aws_iam_role.role2-s3Full.name
  policy_arn = aws_iam_policy.policy2-s3Full.arn
}
