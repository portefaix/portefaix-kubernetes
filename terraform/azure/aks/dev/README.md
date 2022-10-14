## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | < 4.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | ../modules/aks | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agents_availability_zones"></a> [agents\_availability\_zones](#input\_agents\_availability\_zones) | (Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created. | `list(string)` | n/a | yes |
| <a name="input_agents_count"></a> [agents\_count](#input\_agents\_count) | The number of Agents that should exist in the Agent Pool. Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes. | `number` | n/a | yes |
| <a name="input_agents_labels"></a> [agents\_labels](#input\_agents\_labels) | (Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created. | `map(string)` | n/a | yes |
| <a name="input_agents_max_count"></a> [agents\_max\_count](#input\_agents\_max\_count) | Maximum number of nodes in a pool | `number` | n/a | yes |
| <a name="input_agents_max_pods"></a> [agents\_max\_pods](#input\_agents\_max\_pods) | (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created. | `number` | n/a | yes |
| <a name="input_agents_min_count"></a> [agents\_min\_count](#input\_agents\_min\_count) | Minimum number of nodes in a pool | `number` | n/a | yes |
| <a name="input_agents_pool_name"></a> [agents\_pool\_name](#input\_agents\_pool\_name) | The default Azure AKS agentpool (nodepool) name. | `string` | n/a | yes |
| <a name="input_agents_size"></a> [agents\_size](#input\_agents\_size) | The default virtual machine size for the Kubernetes agents | `string` | n/a | yes |
| <a name="input_agents_tags"></a> [agents\_tags](#input\_agents\_tags) | (Optional) A mapping of tags to assign to the Node Pool. | `map(string)` | n/a | yes |
| <a name="input_agents_type"></a> [agents\_type](#input\_agents\_type) | (Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets. | `string` | `"VirtualMachineScaleSets"` | no |
| <a name="input_aks_resource_group_location"></a> [aks\_resource\_group\_location](#input\_aks\_resource\_group\_location) | The Azure Region where the Resource Group for AKS should exist. | `string` | n/a | yes |
| <a name="input_aks_resource_group_name"></a> [aks\_resource\_group\_name](#input\_aks\_resource\_group\_name) | Name of the resource group for AKS | `string` | n/a | yes |
| <a name="input_aks_subnet_name"></a> [aks\_subnet\_name](#input\_aks\_subnet\_name) | Name of the AKS subnet | `string` | n/a | yes |
| <a name="input_api_server_authorized_ip_ranges"></a> [api\_server\_authorized\_ip\_ranges](#input\_api\_server\_authorized\_ip\_ranges) | The IP ranges to allow for incoming traffic to the server nodes. | `set(string)` | `null` | no |
| <a name="input_appgw_subnet_name"></a> [appgw\_subnet\_name](#input\_appgw\_subnet\_name) | Name of the Application Gateway subnet | `string` | n/a | yes |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | Is the Azure Policy for Kubernetes Add On enabled | `bool` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the AKS cluster | `string` | n/a | yes |
| <a name="input_enable_auto_scaling"></a> [enable\_auto\_scaling](#input\_enable\_auto\_scaling) | Enable node pool autoscaling | `bool` | n/a | yes |
| <a name="input_http_application_routing_enabled"></a> [http\_application\_routing\_enabled](#input\_http\_application\_routing\_enabled) | Is HTTP Application Routing Enabled | `bool` | n/a | yes |
| <a name="input_ingress_application_gateway_enabled"></a> [ingress\_application\_gateway\_enabled](#input\_ingress\_application\_gateway\_enabled) | If true will enable Application Gateway ingress controller to this Kubernetes Cluster | `bool` | `false` | no |
| <a name="input_key_vault_secrets_provider_enabled"></a> [key\_vault\_secrets\_provider\_enabled](#input\_key\_vault\_secrets\_provider\_enabled) | Whether to use the Azure Key Vault Provider for Secrets Store CSI Driver in an AKS cluster | `bool` | `false` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The AKS Kubernetes version | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | (Optional) Maintenance configuration of the managed cluster. | <pre>object({<br>    allowed = list(object({<br>      day   = string<br>      hours = set(number)<br>    })),<br>    not_allowed = list(object({<br>      end   = string<br>      start = string<br>    })),<br>  })</pre> | `null` | no |
| <a name="input_net_profile_dns_service_ip"></a> [net\_profile\_dns\_service\_ip](#input\_net\_profile\_dns\_service\_ip) | (Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_net_profile_docker_bridge_cidr"></a> [net\_profile\_docker\_bridge\_cidr](#input\_net\_profile\_docker\_bridge\_cidr) | (Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_net_profile_service_cidr"></a> [net\_profile\_service\_cidr](#input\_net\_profile\_service\_cidr) | (Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | The CNI network plugin to use (only azure, or kubenet) | `string` | `"kubenet"` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | The network polcy for the CNI. Only used when network\_plugin is set to azure. Supported values: calico, azure | `string` | n/a | yes |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | Addons node pools | <pre>list(object({<br>    name                = string<br>    vm_size             = string<br>    os_disk_size_gb     = number<br>    os_disk_type        = string<br>    priority            = string<br>    enable_auto_scaling = bool<br>    count               = number<br>    min_count           = number<br>    max_count           = number<br>    max_pods            = number<br>    taints              = list(string)<br>    labels              = map(string)<br>    tags                = map(string)<br>  }))</pre> | `[]` | no |
| <a name="input_open_service_mesh_enabled"></a> [open\_service\_mesh\_enabled](#input\_open\_service\_mesh\_enabled) | Is Open Service Mesh enabled. | `bool` | `null` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | Disk size of nodes in GBs. | `number` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | (Required) The prefix for the resources created in the specified Azure Resource Group | `string` | n/a | yes |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | If true cluster API server will be exposed only on internal IP address and available only in cluster vnet. | `bool` | n/a | yes |
| <a name="input_public_ssh_key"></a> [public\_ssh\_key](#input\_public\_ssh\_key) | A custom ssh key to control access to the AKS cluster | `string` | `""` | no |
| <a name="input_secret_rotation_enabled"></a> [secret\_rotation\_enabled](#input\_secret\_rotation\_enabled) | Is secret rotation enabled | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the Virtual Network resources | `map(string)` | `{}` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | Name of the Virtual Network this Subnet is located within | `string` | n/a | yes |
| <a name="input_vnet_resource_group_name"></a> [vnet\_resource\_group\_name](#input\_vnet\_resource\_group\_name) | The Name which should be used for the networking Resource Group | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
