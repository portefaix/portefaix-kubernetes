## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.17.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_chatbot"></a> [chatbot](#module\_chatbot) | ../modules/chatbot | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_labmda_invoke"></a> [allow\_labmda\_invoke](#input\_allow\_labmda\_invoke) | Allow users to invoke Lambda functions from Slack. | `bool` | `false` | no |
| <a name="input_allow_notifications"></a> [allow\_notifications](#input\_allow\_notifications) | Grant read access for CloudWatch to AWS Chatbot. | `bool` | `true` | no |
| <a name="input_allow_read_only_access"></a> [allow\_read\_only\_access](#input\_allow\_read\_only\_access) | Provide users with read access to all AWS resources from within Slack. | `bool` | `false` | no |
| <a name="input_allow_support_access"></a> [allow\_support\_access](#input\_allow\_support\_access) | Allow users to interact with AWS support from Slack. | `bool` | `false` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags for the AWS provider | `map(string)` | <pre>{<br>  "Made-By": "Terraform",<br>  "Portefaix-Version": "v0.41.0",<br>  "Project": "Portefaix"<br>}</pre> | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Log level AWS Chatbot should use. Possible values are ERROR, INFO, NONE | `string` | `"INFO"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of Slack channel configuration in AWS Chatbot. | `string` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Name of the AWS Organization | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_shared_account_id"></a> [shared\_account\_id](#input\_shared\_account\_id) | ID of the Shared AWS Account | `string` | n/a | yes |
| <a name="input_slack_channel_id"></a> [slack\_channel\_id](#input\_slack\_channel\_id) | ID of the Slack channel configure with AWS Chatbot | `string` | n/a | yes |
| <a name="input_slack_workspace_id"></a> [slack\_workspace\_id](#input\_slack\_workspace\_id) | ID of the Slack workspace containing the channel to use with AWS Chatbot | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for AWS resources | `map(string)` | <pre>{<br>  "Service": "AWS ChatBot"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
