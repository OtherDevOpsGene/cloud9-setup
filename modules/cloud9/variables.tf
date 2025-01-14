variable "aws_account" {
  description = "The account ID for this account."
  type        = string
}

variable "aws_region" {
  description = "The AWS region."
  type        = string
}

variable "instructor" {
  description = "The username of the instructor."
  type        = string
  default     = "OtherDevOpsGene"
}

variable "instance_type" {
  description = "The instance_type for the Cloud9 instances."
  type        = string
  default     = "t3.small"
}

variable "username" {
  description = "The username for this account."
  type        = string
}

variable "domains" {
  description = "The domains to use for DNS records."
  type        = list(string)
}

variable "subdomain" {
  description = "The subdomain to use for DNS records."
  type        = string
}
