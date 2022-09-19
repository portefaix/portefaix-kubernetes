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
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ../modules/bastion | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_name"></a> [asg\_name](#input\_asg\_name) | Name of the bastion ASG | `string` | n/a | yes |
| <a name="input_asg_tags"></a> [asg\_tags](#input\_asg\_tags) | Tags for the bastion | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| <a name="input_core_account_id"></a> [core\_account\_id](#input\_core\_account\_id) | ID of the Core AWS Account | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags for the AWS provider | `map(string)` | <pre>{<br>  "Made-By": "Terraform",<br>  "Portefaix-Version": "v0.41.0",<br>  "Project": "Portefaix"<br>}</pre> | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the autoscaling group | `number` | n/a | yes |
| <a name="input_ec2_ssm_role_name"></a> [ec2\_ssm\_role\_name](#input\_ec2\_ssm\_role\_name) | Name of the AWS project | `string` | n/a | yes |
| <a name="input_ec2_ssm_tags"></a> [ec2\_ssm\_tags](#input\_ec2\_ssm\_tags) | Tags for the bastion | `map(string)` | <pre>{<br>  "Service": "Bastion"<br>}</pre> | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance to launch | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the autoscaling group | `number` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the autoscaling group | `number` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Name of the AWS Organization | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_sg_name"></a> [sg\_name](#input\_sg\_name) | Name for the security groups | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | ID of the VPC | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
