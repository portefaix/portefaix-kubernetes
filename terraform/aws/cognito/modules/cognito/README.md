## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.68.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.68.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_identity_pool.this](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/cognito_identity_pool) | resource |
| [aws_cognito_identity_pool_roles_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/cognito_identity_pool_roles_attachment) | resource |
| [aws_iam_group.cognito_app_group](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/iam_group) | resource |
| [aws_iam_openid_connect_provider.auth_zero](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.cognito_sns_role_policy](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.authenticated](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/iam_role) | resource |
| [aws_iam_role.cognito_sns](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/iam_role) | resource |
| [aws_iam_role.unauthenticated](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.authenticated](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.unauthenticated](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.cognito_sns_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.cognito_app_user](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.cognito_app_user_groups](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_policy_document.cognito_sns_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cognito_sns_publish_policy](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_zero_clientid"></a> [auth\_zero\_clientid](#input\_auth\_zero\_clientid) | The Client ID for the Auth0 identity provider | `string` | n/a | yes |
| <a name="input_auth_zero_thumbprint"></a> [auth\_zero\_thumbprint](#input\_auth\_zero\_thumbprint) | The server certificate thumbprints for the Auth0 identity provider | `string` | n/a | yes |
| <a name="input_auth_zero_url"></a> [auth\_zero\_url](#input\_auth\_zero\_url) | The URL of the Auth0 identity provider | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the Cognito service. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
