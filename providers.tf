terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15.0"
    }
  }

  required_version = ">= 1.5.6"
}

provider "aws" {
  region = "us-east-2"
}
