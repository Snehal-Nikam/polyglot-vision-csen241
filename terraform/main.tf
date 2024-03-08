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
  COGNITO_USR_POOL_ARN = ""
}
