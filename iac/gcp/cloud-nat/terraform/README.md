## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.5 |
| google | ~> 3.55.0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.55.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| cloud-nat | terraform-google-modules/cloud-nat/google | = 1.3.0 |

## Resources

| Name |
|------|
| [google_compute_address](https://registry.terraform.io/providers/hashicorp/google/3.55.0/docs/data-sources/compute_address) |
| [google_compute_network](https://registry.terraform.io/providers/hashicorp/google/3.55.0/docs/data-sources/compute_network) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| min\_ports\_per\_vm | Minimum number of ports allocated to a VM from this NAT config | `number` | n/a | yes |
| nat\_external\_ip\_0\_name | Name of the first External IP to use | `string` | n/a | yes |
| nat\_external\_ip\_1\_name | Name of the second External IP to use | `string` | n/a | yes |
| nat\_name | Name of the Cloud NAT | `string` | n/a | yes |
| nat\_network | Name of the network | `string` | n/a | yes |
| nat\_router\_name | The name of the router in which this NAT will be configured | `string` | n/a | yes |
| project | n/a | `string` | n/a | yes |
| region | n/a | `string` | n/a | yes |

## Outputs

No output.
