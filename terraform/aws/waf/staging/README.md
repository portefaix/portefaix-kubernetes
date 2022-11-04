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
| <a name="module_waf"></a> [waf](#module\_waf) | ../modules/waf | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_ipv4"></a> [admin\_ipv4](#input\_admin\_ipv4) | Allow Admins IP addresses for IPV4 addresses | `list(string)` | `[]` | no |
| <a name="input_allowed_country_codes"></a> [allowed\_country\_codes](#input\_allowed\_country\_codes) | Whitelist access by country | `list(string)` | `[]` | no |
| <a name="input_blacklist_ipv4"></a> [blacklist\_ipv4](#input\_blacklist\_ipv4) | Block blacklist for IPV4 addresses | `list(string)` | `[]` | no |
| <a name="input_cloudwatch_metrics_enabled"></a> [cloudwatch\_metrics\_enabled](#input\_cloudwatch\_metrics\_enabled) | Indicating whether the associated resource sends metrics to CloudWatch | `bool` | `false` | no |
| <a name="input_core_account_id"></a> [core\_account\_id](#input\_core\_account\_id) | ID of the Core AWS Account | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags for the AWS provider | `map(string)` | <pre>{<br>  "Made-By": "Terraform",<br>  "Portefaix-Version": "v0.41.0",<br>  "Project": "Portefaix"<br>}</pre> | no |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Name of the AWS Organization | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | Specifies whether this is for an AWS CloudFront distribution or for a regional application | `string` | `"REGIONAL"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the service | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the WAF resources | `map(string)` | <pre>{<br>  "Service": "WAF"<br>}</pre> | no |
| <a name="input_whitelist_ipv4"></a> [whitelist\_ipv4](#input\_whitelist\_ipv4) | Allow whitelist for IPV4 addresses | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_web_acl_arn"></a> [web\_acl\_arn](#output\_web\_acl\_arn) | The ARN of the WAFv2 WebACL. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
