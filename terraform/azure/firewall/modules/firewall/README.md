## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
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
| [azurerm_firewall.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/resources/firewall) | resource |
| [azurerm_firewall_application_rule_collection.aksbasics](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/resources/firewall_application_rule_collection) | resource |
| [azurerm_firewall_application_rule_collection.publicimages](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/resources/firewall_application_rule_collection) | resource |
| [azurerm_firewall_network_rule_collection.dns](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/resources/firewall_network_rule_collection) | resource |
| [azurerm_firewall_network_rule_collection.servicetags](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/resources/firewall_network_rule_collection) | resource |
| [azurerm_firewall_network_rule_collection.time](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/resources/firewall_network_rule_collection) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/resources/public_ip) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/resources/subnet) | resource |
| [azurerm_resource_group.hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/data-sources/resource_group) | data source |
| [azurerm_virtual_network.hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.5.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hub_rg_name"></a> [hub\_rg\_name](#input\_hub\_rg\_name) | The name of the resource grupe of the Hub virtual network | `string` | n/a | yes |
| <a name="input_hub_vnet_name"></a> [hub\_vnet\_name](#input\_hub\_vnet\_name) | The name of the Hub virtual network | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Specifies the name of the Firewall | `string` | n/a | yes |
| <a name="input_subnet_prefix"></a> [subnet\_prefix](#input\_subnet\_prefix) | The address prefix to use for the Azure Bastion subnet | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
