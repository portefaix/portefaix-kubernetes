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
| <a name="module_security_hub"></a> [security\_hub](#module\_security\_hub) | ../modules/security-hub | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_audit_account_id"></a> [audit\_account\_id](#input\_audit\_account\_id) | ID of the Audit AWS Account | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags for the AWS provider | `map(string)` | <pre>{<br>  "Made-By": "Terraform",<br>  "Portefaix-Version": "v0.41.0",<br>  "Project": "Portefaix"<br>}</pre> | no |
| <a name="input_enable_aws_foundational"></a> [enable\_aws\_foundational](#input\_enable\_aws\_foundational) | Enable AWS Foundational Security Best Practices | `bool` | n/a | yes |
| <a name="input_enable_cis"></a> [enable\_cis](#input\_enable\_cis) | Enable CIS AWS Foundations | `bool` | n/a | yes |
| <a name="input_enable_pci_dss"></a> [enable\_pci\_dss](#input\_enable\_pci\_dss) | Enable Payment Card Industry Data Security Standard (PCI DSS | `bool` | n/a | yes |
| <a name="input_members"></a> [members](#input\_members) | Security Hub members | `map(string)` | n/a | yes |
| <a name="input_org_email"></a> [org\_email](#input\_org\_email) | Email of the AWS Organization | `string` | n/a | yes |
| <a name="input_org_email_domain"></a> [org\_email\_domain](#input\_org\_email\_domain) | Email domain of the AWS Organization (like gmail.com) | `string` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Name of the AWS Organization | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the service | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for AWS resources | `map(string)` | <pre>{<br>  "Service": "Security Hub"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
