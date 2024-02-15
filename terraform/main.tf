terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.35.0"
    }
  }
}
provider "aws" {
  region = "us-west-2"
}

#module "security" {
#  source = "./security"
#}
#
#module "S3" {
#  source = "./s3"
#}

#module "cognito" {
#  source = "./cognito"
#  CALLBACK_URLS = ""
#  COGNITO_USER_POOL_CLIENT_NAME = ""
#  COGNITO_USER_POOL_NAME = ""
#  LOGOUT_URLS = ""
#}

module "lambda" {
  source = "./lambda"
}
