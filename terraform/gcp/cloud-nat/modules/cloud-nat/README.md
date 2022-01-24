## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_nat"></a> [cloud\_nat](#module\_cloud\_nat) | terraform-google-modules/cloud-nat/google | 2.1.0 |

## Resources

| Name | Type |
|------|------|
| [google_compute_network.vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_min_ports_per_vm"></a> [min\_ports\_per\_vm](#input\_min\_ports\_per\_vm) | Minimum number of ports allocated to a VM from this NAT config | `number` | n/a | yes |
| <a name="input_nat_ips"></a> [nat\_ips](#input\_nat\_ips) | List of self\_links of external IPs. Changing this forces a new NAT to be created. | `list(string)` | `[]` | no |
| <a name="input_nat_name"></a> [nat\_name](#input\_nat\_name) | Name of the Cloud NAT | `string` | n/a | yes |
| <a name="input_nat_network"></a> [nat\_network](#input\_nat\_network) | Name of the network | `string` | n/a | yes |
| <a name="input_nat_router_name"></a> [nat\_router\_name](#input\_nat\_router\_name) | The name of the router in which this NAT will be configured | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project in which the resource belongs | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The location linked to the project | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
