terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.51.1"
    }
  }

  required_version = ">= 1.8.4"
}

provider "aws" {
  region = var.aws_region
}
