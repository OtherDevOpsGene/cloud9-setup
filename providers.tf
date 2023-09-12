terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.16.1"
    }
  }

  required_version = ">= 1.5.7"

  backend "s3" {
    region         = "us-east-2"
    bucket         = "otherdevopsgene-cloud9-class-gg-tf"
    key            = "terraform.tfstate"
    dynamodb_table = "otherdevopsgene-cloud9-class-gg-tf-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Class = var.class_name
      Owner = var.owner_email
    }
  }
}
