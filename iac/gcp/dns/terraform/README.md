## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.5 |
| google | 3.74.0 |

## Providers

| Name | Version |
|------|---------|
| google | 3.74.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| dns | terraform-google-modules/cloud-dns/google | 3.1.0 |

## Resources

| Name |
|------|
| [google_compute_network](https://registry.terraform.io/providers/hashicorp/google/3.74.0/docs/data-sources/compute_network) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain\_name | Zone domain, must end with a period. | `string` | n/a | yes |
| labels | Map of labels to apply to the DNS | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| network\_name | Name of the network to use | `string` | n/a | yes |
| project | The project in which the resource belongs | `string` | n/a | yes |
| region | The location linked to the project | `string` | n/a | yes |
| zone\_name | Zone name | `string` | n/a | yes |

## Outputs

No output.
