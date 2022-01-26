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
| <a name="module_chatbot"></a> [chatbot](#module\_chatbot) | terraform-aws-modules/eventbridge/aws | 1.13.4 |
| <a name="module_securityhub"></a> [securityhub](#module\_securityhub) | terraform-aws-modules/eventbridge/aws | 1.13.4 |

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic.chatbot](https://registry.terraform.io/providers/hashicorp/aws/3.73.0/docs/data-sources/sns_topic) | data source |
| [aws_sns_topic.security](https://registry.terraform.io/providers/hashicorp/aws/3.73.0/docs/data-sources/sns_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bus_name"></a> [bus\_name](#input\_bus\_name) | A unique name for your EventBridge Bus | `string` | n/a | yes |
| <a name="input_sns_chatbot_topic_name"></a> [sns\_chatbot\_topic\_name](#input\_sns\_chatbot\_topic\_name) | Name of SNS topic for AWS ChatBot. | `string` | n/a | yes |
| <a name="input_sns_security_topic_name"></a> [sns\_security\_topic\_name](#input\_sns\_security\_topic\_name) | Name of SNS topic for AWS SecurityHub. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for AWS resources | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
