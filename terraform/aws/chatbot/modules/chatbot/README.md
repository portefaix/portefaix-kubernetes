## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.75.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_chatbot"></a> [chatbot](#module\_chatbot) | waveaccounting/chatbot-slack-configuration/aws | 1.1.0 |
| <a name="module_eventbridge"></a> [eventbridge](#module\_eventbridge) | terraform-aws-modules/eventbridge/aws | 1.14.0 |
| <a name="module_sns_topic"></a> [sns\_topic](#module\_sns\_topic) | terraform-aws-modules/sns/aws | 3.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.lambda_invoke](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.notifications](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.read_only_access](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.support_access](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_invoke](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.notifications](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_labmda_invoke"></a> [allow\_labmda\_invoke](#input\_allow\_labmda\_invoke) | Allow users to invoke Lambda functions from Slack. | `bool` | `false` | no |
| <a name="input_allow_notifications"></a> [allow\_notifications](#input\_allow\_notifications) | Grant read access for CloudWatch to AWS Chatbot. | `bool` | `true` | no |
| <a name="input_allow_read_only_access"></a> [allow\_read\_only\_access](#input\_allow\_read\_only\_access) | Provide users with read access to all AWS resources from within Slack. | `bool` | `false` | no |
| <a name="input_allow_support_access"></a> [allow\_support\_access](#input\_allow\_support\_access) | Allow users to interact with AWS support from Slack. | `bool` | `false` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the SNS topic | `string` | `"Managed by Terraform"` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Log level AWS Chatbot should use. Possible values are ERROR, INFO, NONE | `string` | `"INFO"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of Slack channel configuration in AWS Chatbot. | `string` | n/a | yes |
| <a name="input_slack_channel_id"></a> [slack\_channel\_id](#input\_slack\_channel\_id) | ID of the Slack channel configure with AWS Chatbot | `string` | n/a | yes |
| <a name="input_slack_workspace_id"></a> [slack\_workspace\_id](#input\_slack\_workspace\_id) | ID of the Slack workspace containing the channel to use with AWS Chatbot | `string` | n/a | yes |
| <a name="input_sns_create_topic"></a> [sns\_create\_topic](#input\_sns\_create\_topic) | Whether to create the SNS topic | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for AWS resources | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
