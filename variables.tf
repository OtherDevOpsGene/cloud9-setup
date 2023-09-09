variable "owner_email" {
  description = "The email address of the person responsible for the resources."
  type        = string
}

variable "class_name" {
  description = "The name of the class this was created for."
  type        = string
  default     = "Terraform Fundamentals"
}

variable "aws_account" {
  description = "The account ID for this account."
  type        = string
  #  sensitive   = true
}

variable "instance_type" {
  description = "The instance_type for the Cloud9 instances."
  type        = string
  default     = "t3.small"
}

variable "password" {
  description = "The initial passwords for the accounts. They must be changed on first login."
  type        = string
}