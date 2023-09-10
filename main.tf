locals {
  # first line is a header, one username per line
  students = csvdecode(file("${path.module}/students.csv"))

  # create with gpg --export OtherDevOpsGene | base64 > OtherDevOpsGene-pub.b64
  pub_key = file("${path.module}/OtherDevOpsGene-pub.b64")
}

module "policies" {
  source = "./policies"
}

module "account" {
  source = "./account"

  for_each = { for acct in local.students : acct.username => acct }
  username = each.value.username
  password = var.password
  pub_key  = local.pub_key
}

module "cloud9" {
  source = "./cloud9"

  for_each = { for acct in local.students : acct.username => acct }
  username = each.value.username

  aws_account   = var.aws_account
  aws_region    = var.aws_region
  instance_type = var.instance_type
}

output "cloud9" {
  value = values(module.cloud9)[*].cloud9
  # sensitive = true
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

# decrypt with for p in $(terraform output --json acct_password | jq -r .[]); do echo ${p} | base64 -d | gpg -d && echo; done
output "acct_password" {
  value = values(module.account)[*].acct_password
}
