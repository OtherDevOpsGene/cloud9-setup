# account

A Terraform module to set up an AWS account with an initial password.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_user.account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_password"></a> [password](#input\_password) | The initial password for this account. It must be changed on first login. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | The username for this account. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
