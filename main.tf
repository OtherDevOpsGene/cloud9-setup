locals {
  students = csvdecode(file("${path.module}/students.csv"))
}

module "account" {
  source = "./account"

  for_each = { for acct in local.students : acct.username => acct }
  username = each.value.username
  password = var.password

  owner_email = var.owner_email
  class_name  = var.class_name
}

module "cloud9" {
  source = "./cloud9"

  for_each = { for acct in local.students : acct.username => acct }
  username = each.value.username

  aws_account   = var.aws_account
  instance_type = var.instance_type
  owner_email   = var.owner_email
  class_name    = var.class_name
}

output "cloud9" {
  value = values(module.cloud9)[*].cloud9
}

output "route53_cname" {
  value = values(module.cloud9)[*].route53_cname
}

output "redirect" {
  value = values(module.cloud9)[*].redirect
}

output "bucket" {
  value = values(module.cloud9)[*].bucket
}
