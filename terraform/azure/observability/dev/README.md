## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 2.88.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_observability"></a> [observability](#module\_observability) | ../modules/observability | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_loki_resource_group_location"></a> [loki\_resource\_group\_location](#input\_loki\_resource\_group\_location) | The Azure Region where the Resource Group should exist | `string` | n/a | yes |
| <a name="input_loki_resource_group_name"></a> [loki\_resource\_group\_name](#input\_loki\_resource\_group\_name) | The Name which should be used for this Resource Group | `string` | n/a | yes |
| <a name="input_loki_tags"></a> [loki\_tags](#input\_loki\_tags) | A mapping of tags to assign to the resource. | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| <a name="input_prometheus_resource_group_location"></a> [prometheus\_resource\_group\_location](#input\_prometheus\_resource\_group\_location) | The Azure Region where the Resource Group should exist | `string` | n/a | yes |
| <a name="input_prometheus_resource_group_name"></a> [prometheus\_resource\_group\_name](#input\_prometheus\_resource\_group\_name) | The Name which should be used for this Resource Group | `string` | n/a | yes |
| <a name="input_prometheus_tags"></a> [prometheus\_tags](#input\_prometheus\_tags) | A mapping of tags to assign to the resource. | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| <a name="input_tempo_resource_group_location"></a> [tempo\_resource\_group\_location](#input\_tempo\_resource\_group\_location) | The Azure Region where the Resource Group should exist | `string` | n/a | yes |
| <a name="input_tempo_resource_group_name"></a> [tempo\_resource\_group\_name](#input\_tempo\_resource\_group\_name) | The Name which should be used for this Resource Group | `string` | n/a | yes |
| <a name="input_tempo_tags"></a> [tempo\_tags](#input\_tempo\_tags) | A mapping of tags to assign to the resource. | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| <a name="input_thanos_resource_group_location"></a> [thanos\_resource\_group\_location](#input\_thanos\_resource\_group\_location) | The Azure Region where the Resource Group should exist | `string` | n/a | yes |
| <a name="input_thanos_resource_group_name"></a> [thanos\_resource\_group\_name](#input\_thanos\_resource\_group\_name) | The Name which should be used for this Resource Group | `string` | n/a | yes |
| <a name="input_thanos_tags"></a> [thanos\_tags](#input\_thanos\_tags) | A mapping of tags to assign to the resource. | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_loki_user_assigned_identity_id"></a> [loki\_user\_assigned\_identity\_id](#output\_loki\_user\_assigned\_identity\_id) | ID of the user assigned identity |
| <a name="output_loki_user_assigned_identity_name"></a> [loki\_user\_assigned\_identity\_name](#output\_loki\_user\_assigned\_identity\_name) | Name of the user assigned identity |
| <a name="output_prometheus_user_assigned_identity_id"></a> [prometheus\_user\_assigned\_identity\_id](#output\_prometheus\_user\_assigned\_identity\_id) | ID of the user assigned identity |
| <a name="output_prometheus_user_assigned_identity_name"></a> [prometheus\_user\_assigned\_identity\_name](#output\_prometheus\_user\_assigned\_identity\_name) | Name of the user assigned identity |
| <a name="output_tempo_user_assigned_identity_id"></a> [tempo\_user\_assigned\_identity\_id](#output\_tempo\_user\_assigned\_identity\_id) | ID of the user assigned identity |
| <a name="output_tempo_user_assigned_identity_name"></a> [tempo\_user\_assigned\_identity\_name](#output\_tempo\_user\_assigned\_identity\_name) | Name of the user assigned identity |
| <a name="output_thanos_user_assigned_identity_id"></a> [thanos\_user\_assigned\_identity\_id](#output\_thanos\_user\_assigned\_identity\_id) | ID of the user assigned identity |
| <a name="output_thanos_user_assigned_identity_name"></a> [thanos\_user\_assigned\_identity\_name](#output\_thanos\_user\_assigned\_identity\_name) | Name of the user assigned identity |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
