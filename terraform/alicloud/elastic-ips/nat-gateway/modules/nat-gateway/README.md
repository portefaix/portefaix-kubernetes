## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | 1.148.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.148.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eip_nat_gateway"></a> [eip\_nat\_gateway](#module\_eip\_nat\_gateway) | terraform-alicloud-modules/eip/alicloud//modules/associate-with-nat-gateway | 1.2.0 |

## Resources

| Name | Type |
|------|------|
| [alicloud_nat_gateways.this](https://registry.terraform.io/providers/aliyun/alicloud/1.148.0/docs/data-sources/nat_gateways) | data source |
| [alicloud_vpcs.this](https://registry.terraform.io/providers/aliyun/alicloud/1.148.0/docs/data-sources/vpcs) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eip_name"></a> [eip\_name](#input\_eip\_name) | Name of the Elastic IP | `string` | n/a | yes |
| <a name="input_nat_gateway_name"></a> [nat\_gateway\_name](#input\_nat\_gateway\_name) | Name of the NAT Gateway | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for Nat Gateway Elastic IP | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eip_address"></a> [eip\_address](#output\_eip\_address) | The elastic ip address. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
