variable "owner_email" {
  description = "The email address of the person responsible for the resources."
  type        = string
}

variable "class_name" {
  description = "The name of the class this was created for."
  type        = string
  default     = "Terraform Fundamentals"
}

variable "class_initials" {
  description = "The initials of the class this was created for, so the buckets are named uniquely."
  type        = string
  default     = "gg-tf"
}

variable "aws_account" {
  description = "The account ID for this account."
  type        = string
  #  sensitive   = true
}

variable "aws_region" {
  description = "The AWS region."
  type        = string
  default     = "us-east-2"
}

variable "instance_type" {
  description = "The instance_type for the Cloud9 instances."
  type        = string
  default     = "t3.small"
}

variable "domains" {
  description = "The domains to use for DNS records."
  type        = list(string)
}

variable "subdomain" {
  description = "The subdomain to use for DNS records."
  type        = string
}
