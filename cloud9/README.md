# cloud9

A Terraform module to set up a Cloud9 environment.

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
| [aws_cloud9_environment_ec2.class](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloud9_environment_ec2) | resource |
| [aws_cloud9_environment_membership.instructor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloud9_environment_membership) | resource |
| [aws_route53_record.cloud9_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.cloud9](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_website_configuration.redirect_cloud9](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_route53_zone.otherdevopsgene_dev](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account"></a> [aws\_account](#input\_aws\_account) | The account ID for this account. | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region. | `string` | `"us-east-2"` | no |
| <a name="input_class_name"></a> [class\_name](#input\_class\_name) | The name of the class this was created for. | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance\_type for the Cloud9 instances. | `string` | `"t3.small"` | no |
| <a name="input_instructor"></a> [instructor](#input\_instructor) | The username of the instructor. | `string` | `"OtherDevOpsGene"` | no |
| <a name="input_owner_email"></a> [owner\_email](#input\_owner\_email) | The email address of the person responsible for the resources. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | The username for this account. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | n/a |
| <a name="output_cloud9"></a> [cloud9](#output\_cloud9) | n/a |
| <a name="output_redirect"></a> [redirect](#output\_redirect) | n/a |
| <a name="output_route53_cname"></a> [route53\_cname](#output\_route53\_cname) | n/a |
<!-- END_TF_DOCS -->
