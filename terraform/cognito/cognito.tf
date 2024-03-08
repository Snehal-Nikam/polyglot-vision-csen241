resource "aws_cognito_user_pool" "polyglot" {
  mfa_configuration = "OFF"
  name              = var.COGNITO_USER_POOL_NAME

  username_attributes = [
    "email",
  ]

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  password_policy {
    minimum_length                   = 6
    require_lowercase                = false
    require_numbers                  = false
    require_symbols                  = false
    require_uppercase                = false
    temporary_password_validity_days = 6
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }

  }

  username_configuration {
    case_sensitive = false
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }

  #lambda_config {
  #  pre_sign_up = "arn:aws:lambda:us-west-2:${var.ACCOUNT_ID}:function:${var.AUTO_APPROVE_LAMBDA}"
  #}
}

resource "aws_cognito_user_pool_domain" "cognito_domain" {
  domain       = "polyglot"
  user_pool_id = aws_cognito_user_pool.polyglot.id
}

