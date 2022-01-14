## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | 1.148.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key_pair"></a> [key\_pair](#module\_key\_pair) | ../modules/key-pair | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | The key pair's name. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags associated to the resources | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
