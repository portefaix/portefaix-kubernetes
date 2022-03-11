## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.74.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ../modules/alb | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_alb_tags"></a> [alb\_tags](#input\_alb\_tags) | A map of tags to add to all resources. | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags for the AWS provider | `map(string)` | <pre>{<br>  "Made-By": "terraform",<br>  "Project": "portefaix"<br>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | ID of the VPC | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
