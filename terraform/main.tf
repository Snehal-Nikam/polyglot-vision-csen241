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

module "lambda" {
  source = "./lambda"
}

module "cognito" {
  source = "./cognito"
  CALLBACK_URLS = ["https://0.0.0.0:8000"] #TODO : Change
  COGNITO_USER_POOL_CLIENT_NAME = "ployglot-vision"
  COGNITO_USER_POOL_NAME = "polyglot-user-pool"
  LOGOUT_URLS = ["https://0.0.0.0:8000"] #TODO : Change
}

