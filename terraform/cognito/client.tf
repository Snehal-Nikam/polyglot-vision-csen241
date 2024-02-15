
resource "aws_cognito_user_pool_client" "polyglot" {
  access_token_validity = 60
  allowed_oauth_flows = [
    "code",
  ]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes = [
    "aws.cognito.signin.user.admin",
  ]
  auth_session_validity                         = 3
  callback_urls                                 = var.CALLBACK_URLS
  enable_propagate_additional_user_context_data = false
  enable_token_revocation                       = true
  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
  ]

  id_token_validity             = 60
  logout_urls                   = var.LOGOUT_URLS
  name                          = var.COGNITO_USER_POOL_CLIENT_NAME
  prevent_user_existence_errors = "ENABLED"
  read_attributes = [
    "address",
    "birthdate",
    "email",
    "email_verified",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "phone_number_verified",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo",
  ]
  refresh_token_validity = 30
  supported_identity_providers = [
    "COGNITO",
  ]
  user_pool_id = aws_cognito_user_pool.polyglot.id
  write_attributes = [
    "address",
    "birthdate",
    "email",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo",
  ]

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}
