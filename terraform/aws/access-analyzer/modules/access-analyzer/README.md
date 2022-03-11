## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.74.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.74.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_accessanalyzer_analyzer.this](https://registry.terraform.io/providers/hashicorp/aws/3.74.3/docs/resources/accessanalyzer_analyzer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the Analyzer | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for AWS resources | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |
| <a name="input_type"></a> [type](#input\_type) | Type of Analyzer. Valid values are ACCOUNT or ORGANIZATION | `string` | `"ACCOUNT"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
