terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49.0"
    }
  }

  required_version = ">= 1.8.3"

  backend "s3" {
    region  = "us-east-2"
    bucket  = "otherdevopsgene-cloud9-class-gg-do"
    key     = "terraform.tfstate"
    profile = ""
    encrypt = "true"

    dynamodb_table = "otherdevopsgene-cloud9-class-gg-do-lock"
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
