## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/resources/resource_group) | resource |
| [azurerm_traffic_manager_azure_endpoint.example](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/resources/traffic_manager_azure_endpoint) | resource |
| [azurerm_traffic_manager_profile.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/resources/traffic_manager_profile) | resource |
| [azurerm_public_ip.appgw_westeurope](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/data-sources/public_ip) | data source |
| [azurerm_resource_group.hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appgw_westeurope_ip_name"></a> [appgw\_westeurope\_ip\_name](#input\_appgw\_westeurope\_ip\_name) | Name of the IP Address for the Application Gateway | `string` | n/a | yes |
| <a name="input_dns_ttl"></a> [dns\_ttl](#input\_dns\_ttl) | The TTL value of the Profile used by Local DNS resolvers and clients | `number` | `60` | no |
| <a name="input_hub_rg_name"></a> [hub\_rg\_name](#input\_hub\_rg\_name) | The name of the resource grupe of the Hub virtual network | `string` | n/a | yes |
| <a name="input_monitor_path"></a> [monitor\_path](#input\_monitor\_path) | The path used by the monitoring checks | `string` | `""` | no |
| <a name="input_monitor_port"></a> [monitor\_port](#input\_monitor\_port) | The port number used by the monitoring checks | `number` | `80` | no |
| <a name="input_monitor_probe_interval"></a> [monitor\_probe\_interval](#input\_monitor\_probe\_interval) | The interval used to check the endpoint health from a Traffic Manager probing agent | `number` | `10` | no |
| <a name="input_monitor_probe_timeout"></a> [monitor\_probe\_timeout](#input\_monitor\_probe\_timeout) | The amount of time the Traffic Manager probing agent should wait before considering that check a failure | `number` | `5` | no |
| <a name="input_monitor_protocol"></a> [monitor\_protocol](#input\_monitor\_protocol) | The protocol used by the monitoring checks, supported values are HTTP, HTTPS and TCP. | `string` | `"tcp"` | no |
| <a name="input_monitor_tolerated_failures"></a> [monitor\_tolerated\_failures](#input\_monitor\_tolerated\_failures) | The number of failures a Traffic Manager probing agent tolerates before marking that endpoint as unhealthy | `number` | `3` | no |
| <a name="input_profile_name"></a> [profile\_name](#input\_profile\_name) | Traffic Manager profile name | `string` | n/a | yes |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | The Azure Region where the Resource Group for Traffic Manager should exist. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group for Traffic Manager | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
