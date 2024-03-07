data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com","lambda.amazonaws.com"]
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
resource "aws_iam_role" "transcribe-lambda-role" {
  name               = "transcribe-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
resource "aws_iam_role" "translate-lambda-role" {
  name               = "translate-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
resource "aws_iam_role" "subtitles-lambda-role" {
  name               = "subtitles-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
resource "aws_iam_role" "pre-signup-lambda-role" {
  name               = "pre-signup-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
resource "aws_iam_role" "final-lambda-role" {
  name               = "final-lambda-role"
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
resource "aws_iam_policy" "policy-transcribe-lambda-role" {
  name        = "policy-transcribe-lambda-role"
  description = "A policy for transcribe-lambda-role"
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
      },
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:logs:*:*:*"
      }
    ]
  })
}
resource "aws_iam_policy" "policy-translate-lambda-role" {
  name        = "policy-translate-lambda-role"
  description = "A policy for translate-lambda-role"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:*",
          "translate:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      },
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:logs:*:*:*"
      }
    ]
  })
}
resource "aws_iam_policy" "policy-subtitles-lambda-role" {
  name        = "policy-subtitles-lambda-role"
  description = "A policy for subtitles-lambda-role"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action" : [
          "s3:*",
          "ec2:*"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:logs:*:*:*"
      }
    ]
  })
}
resource "aws_iam_policy" "policy-final-lambda-role" {
  name        = "policy-final-lambda-role"
  description = "A policy for final-lambda-role"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action" : [
          "s3:*",
          "s3:Get*",
          "s3:List*",
          "s3:Describe*",
          "s3-object-lambda:Get*",
          "s3-object-lambda:List*",
          "dynamodb:*",
          "ses:*"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_policy" "policy-pre-signup-lambda-role" {
  name        = "policy-pre-signup-lambda"
  description = "A policy for pre signup lambda"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action" : [
          "cognito-idp:AdminCreateUser",
          "cognito-idp:AdminUpdateUserAttributes",
          "cognito-idp:AdminInitiateAuth",
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:logs:*:*:*"
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
resource "aws_iam_role_policy_attachment" "attachment-transcribe-lambda-policy" {
  role       = aws_iam_role.transcribe-lambda-role.name
  policy_arn = aws_iam_policy.policy-transcribe-lambda-role.arn
}
resource "aws_iam_role_policy_attachment" "attachment-translate-lambda-policy" {
  role       = aws_iam_role.translate-lambda-role.name
  policy_arn = aws_iam_policy.policy-translate-lambda-role.arn
}
resource "aws_iam_role_policy_attachment" "attachment-subtitles-lambda-policy" {
  role       = aws_iam_role.subtitles-lambda-role.name
  policy_arn = aws_iam_policy.policy-subtitles-lambda-role.arn
}
resource "aws_iam_role_policy_attachment" "attachment-final-lambda-policy" {
  role       = aws_iam_role.final-lambda-role.name
  policy_arn = aws_iam_policy.policy-final-lambda-role.arn
}
resource "aws_iam_role_policy_attachment" "attachment-pre-signup-lambda-policy" {
  role       = aws_iam_role.pre-signup-lambda-role.name
  policy_arn = aws_iam_policy.policy-pre-signup-lambda-role.arn
}


#resource "aws_iam_policy_attachment" "pre-signup-lambda-role" {
#  name       = "example_lambda_exec_policy_attach"
#  roles      = [aws_iam_role.pre-signup-lambda-role.name]
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
#}
