## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.5 |
| google | 3.74.0 |

## Providers

No provider.

## Modules

| Name | Source | Version |
|------|--------|---------|
| vpc | terraform-google-modules/network/google | 3.3.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project | The project in which the resource belongs | `string` | n/a | yes |
| region | The location linked to the project | `string` | n/a | yes |
| secondary\_ranges | Secondary ranges | <pre>map(list(object({<br>    range_name    = string,<br>    ip_cidr_range = string<br>  })))</pre> | n/a | yes |
| subnet\_cidr | IP range of the subnet | `string` | n/a | yes |
| subnet\_name | Name of the subnet | `string` | n/a | yes |

## Outputs

No output.
