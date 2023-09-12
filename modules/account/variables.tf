variable "username" {
  description = "The username for this account."
  type        = string
}

variable "pub_key" {
  description = "Public key to encrypt the generated password with."
  type        = string
}
