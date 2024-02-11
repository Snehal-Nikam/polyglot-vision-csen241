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

module "security" {
  source = "./Security"
}

module "S3" {
  source = "./S3"
}

module "cognito" {
  source = "./Cognito"
}
