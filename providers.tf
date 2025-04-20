terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.95.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.3.4"
    }
  }

  required_version = ">= 1.11.4"

  backend "s3" {
    region  = "us-east-2"
    bucket  = "otherdevopsgene-cloud9-class"
    key     = "terraform.tfstate"
    profile = ""
    encrypt = "true"

    dynamodb_table = "otherdevopsgene-cloud9-class-lock"
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
