locals {
  # first line is a header, one username per line
  students = csvdecode(file("${path.module}/students.csv"))

  # create with gpg --export OtherDevOpsGene | base64 > OtherDevOpsGene-pub.b64
  pub_key = file("${path.module}/OtherDevOpsGene-pub.b64")
}

module "policies" {
  source = "./modules/policies"
}

module "account" {
  source = "./modules/account"

  for_each = { for acct in local.students : acct.username => acct }
  username = each.value.username
  pub_key  = local.pub_key
}

module "cloud9" {
  source = "./modules/cloud9"

  for_each = { for acct in local.students : acct.username => acct }
  username = each.value.username

  aws_account   = var.aws_account
  aws_region    = var.aws_region
  instance_type = var.instance_type
}

resource "aws_s3_bucket" "for_import" {
  for_each = { for acct in local.students : acct.username => acct }
  bucket   = "bucket-${each.value.username}"

  tags = {
    Lesson = "import"
  }
}

output "class_name" {
  description = "Class name"
  value       = var.class_name
}

output "cloud9_urls" {
  description = "URLs for each of the Cloud9 environments, by username"
  value = {
    for username in keys(module.cloud9) : username => module.cloud9[username].cloud9_url
  }
}

# decrypt with for p in $(terraform output --json passwords | jq -r .[]); do echo ${p} | base64 -d | gpg -d && echo; done
output "passwords" {
  description = "Encrypted passwords for each of the accounts, by username"
  value = {
    for username in keys(module.account) : username => module.account[username].password
  }
}
