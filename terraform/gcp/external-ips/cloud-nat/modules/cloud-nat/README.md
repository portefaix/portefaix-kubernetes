## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.5 |
| google | 3.74.0 |
| google-beta | 3.74.0 |

## Providers

| Name | Version |
|------|---------|
| google-beta | 3.74.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [google-beta_google_compute_address](https://registry.terraform.io/providers/hashicorp/google-beta/3.74.0/docs/resources/google_compute_address) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| external\_ip\_names | Names of the External IP for the Cloud NAT | `set(string)` | n/a | yes |
| labels | Map of labels to apply to the IP address | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| project | The project in which the resource belongs | `string` | n/a | yes |
| region | The region in which the cluster should be created. | `string` | n/a | yes |

## Outputs

No output.
