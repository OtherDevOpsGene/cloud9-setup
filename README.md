# cloud9-setup

Builds Cloud9 environments for a list of users.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.15.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_account"></a> [account](#module\_account) | ./account | n/a |
| <a name="module_cloud9"></a> [cloud9](#module\_cloud9) | ./cloud9 | n/a |
| <a name="module_tfstate-backend"></a> [tfstate-backend](#module\_tfstate-backend) | cloudposse/tfstate-backend/aws | 1.1.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account"></a> [aws\_account](#input\_aws\_account) | The account ID for this account. | `string` | n/a | yes |
| <a name="input_class_name"></a> [class\_name](#input\_class\_name) | The name of the class this was created for. | `string` | `"Terraform Fundamentals"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance\_type for the Cloud9 instances. | `string` | `"t3.small"` | no |
| <a name="input_owner_email"></a> [owner\_email](#input\_owner\_email) | The email address of the person responsible for the resources. | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | The initial passwords for the accounts. They must be changed on first login. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | n/a |
| <a name="output_cloud9"></a> [cloud9](#output\_cloud9) | n/a |
| <a name="output_redirect"></a> [redirect](#output\_redirect) | n/a |
| <a name="output_route53_cname"></a> [route53\_cname](#output\_route53\_cname) | n/a |
| <a name="output_terraform_backend_config"></a> [terraform\_backend\_config](#output\_terraform\_backend\_config) | n/a |
<!-- END_TF_DOCS -->
