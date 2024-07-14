# cloud9-setup

Builds Cloud9 environments for a list of users.

## Setup

Edit `students.csv` to include a header line and a single column of usernames.

```shell
terraform init  # or terraform init --upgrade
terraform apply
bash resize.sh
bash list-accounts.sh > index.html 2>/dev/null
aws s3 cp index.html s3://cloud9.otherdevopsgene.dev/index.html --acl public-read
```

Login accounts are at https://s3.us-east-2.amazonaws.com/cloud9.otherdevopsgene.dev/index.html.

There may be additional tasks to run in the `ansible-java` directory.

## Update docs

```shell
for d in modules/* state-bucket .; do
   pushd ${d} && terraform-docs markdown table --output-file README.md --output-mode inject .
  popd
done
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.57.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_account"></a> [account](#module\_account) | ./modules/account | n/a |
| <a name="module_policies"></a> [policies](#module\_policies) | ./modules/policies | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account"></a> [aws\_account](#input\_aws\_account) | The account ID for this account. | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region. | `string` | `"us-east-2"` | no |
| <a name="input_class_initials"></a> [class\_initials](#input\_class\_initials) | The initials of the class this was created for, so the buckets are named uniquely. | `string` | `"gg-tf"` | no |
| <a name="input_class_name"></a> [class\_name](#input\_class\_name) | The name of the class this was created for. | `string` | `"Terraform Fundamentals"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance\_type for the Cloud9 instances. | `string` | `"t3.small"` | no |
| <a name="input_owner_email"></a> [owner\_email](#input\_owner\_email) | The email address of the person responsible for the resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_class_name"></a> [class\_name](#output\_class\_name) | Class name |
| <a name="output_cloud9_urls"></a> [cloud9\_urls](#output\_cloud9\_urls) | URLs for each of the Cloud9 environments, by username |
| <a name="output_passwords"></a> [passwords](#output\_passwords) | Encrypted passwords for each of the accounts, by username |
<!-- END_TF_DOCS -->
