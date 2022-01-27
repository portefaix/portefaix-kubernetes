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
| <a name="module_eventbridge"></a> [eventbridge](#module\_eventbridge) | terraform-aws-modules/eventbridge/aws | 1.13.4 |
| <a name="module_sns_topic"></a> [sns\_topic](#module\_sns\_topic) | terraform-aws-modules/sns/aws | 3.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_guardduty_detector.this](https://registry.terraform.io/providers/hashicorp/aws/3.73.0/docs/resources/guardduty_detector) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the SNS topic | `string` | `"Managed by Terraform"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the service | `string` | n/a | yes |
| <a name="input_sns_create_topic"></a> [sns\_create\_topic](#input\_sns\_create\_topic) | Whether to create the SNS topic | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for AWS resources | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
