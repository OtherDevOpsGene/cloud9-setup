terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }
  }

  required_version = ">= 1.6.3"

  backend "s3" {
    region         = "us-east-2"
    bucket         = "otherdevopsgene-cloud9-class-gg-tf"
    key            = "terraform.tfstate"
    dynamodb_table = "otherdevopsgene-cloud9-class-gg-tf-lock"
    profile        = ""
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
