## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.73.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.73.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sns_topic"></a> [sns\_topic](#module\_sns\_topic) | terraform-aws-modules/sns/aws | 3.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_securityhub_account.this](https://registry.terraform.io/providers/hashicorp/aws/3.73.0/docs/resources/securityhub_account) | resource |
| [aws_securityhub_standards_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/3.73.0/docs/resources/securityhub_standards_subscription) | resource |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/3.73.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the SNS topic | `string` | `"Managed by Terraform"` | no |
| <a name="input_sns_create_topic"></a> [sns\_create\_topic](#input\_sns\_create\_topic) | Whether to create the SNS topic | `bool` | `true` | no |
| <a name="input_sns_topic_name"></a> [sns\_topic\_name](#input\_sns\_topic\_name) | The name of the SNS topic to create | `string` | n/a | yes |
| <a name="input_standards_arns"></a> [standards\_arns](#input\_standards\_arns) | A list of standards/rulesets to enable | `list(string)` | <pre>[<br>  "standards/aws-foundational-security-best-practices/v/1.0.0",<br>  "standards/pci-dss/v/3.2.1",<br>  "ruleset/cis-aws-foundations-benchmark/v/1.2.0"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for AWS resources | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
