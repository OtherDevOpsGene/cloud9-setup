terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.63.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.4.1"
    }
  }

  required_version = ">= 1.16.1"

  backend "s3" {
    region  = "us-east-2"
    bucket  = "otherdevopsgene-cloud9-class"
    key     = "terraform.tfstate"
    profile = ""
    encrypt = "true"

    use_lockfile = "true"
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
