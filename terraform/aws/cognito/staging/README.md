## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.68.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cognito"></a> [cognito](#module\_cognito) | ../modules/cognito | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_zero_clientid"></a> [auth\_zero\_clientid](#input\_auth\_zero\_clientid) | The Client ID for the Auth0 identity provider | `string` | n/a | yes |
| <a name="input_auth_zero_thumbprint"></a> [auth\_zero\_thumbprint](#input\_auth\_zero\_thumbprint) | The server certificate thumbprints for the Auth0 identity provider | `string` | n/a | yes |
| <a name="input_auth_zero_url"></a> [auth\_zero\_url](#input\_auth\_zero\_url) | The URL of the Auth0 identity provider | `string` | n/a | yes |
| <a name="input_callback_urls"></a> [callback\_urls](#input\_callback\_urls) | List of allowed callback URLs for the identity providers | `list(string)` | n/a | yes |
| <a name="input_cognito_idp_region"></a> [cognito\_idp\_region](#input\_cognito\_idp\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags for the AWS provider | `map(string)` | <pre>{<br>  "Made-By": "terraform",<br>  "Project": "portefaix"<br>}</pre> | no |
| <a name="input_logout_urls"></a> [logout\_urls](#input\_logout\_urls) | List of allowed logout URLs for the identity providers. | `list(string)` | n/a | yes |
| <a name="input_mfa_configuration"></a> [mfa\_configuration](#input\_mfa\_configuration) | Multi-Factor Authentication (MFA) configuration for the User Pool. | `string` | `"OPTIONAL"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the Cognito service. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
