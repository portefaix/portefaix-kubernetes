## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| google | 3.84.0 |

## Providers

| Name | Version |
|------|---------|
| google | 3.84.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| iap_bastion | terraform-google-modules/bastion-host/google | 4.0.0 |

## Resources

| Name |
|------|
| [google_compute_network](https://registry.terraform.io/providers/hashicorp/google/3.84.0/docs/data-sources/compute_network) |
| [google_compute_subnetwork](https://registry.terraform.io/providers/hashicorp/google/3.84.0/docs/data-sources/compute_subnetwork) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| disk\_size\_gb | Boot disk size in GB | `any` | n/a | yes |
| disk\_type | Boot disk type, can be either pd-ssd, local-ssd, or pd-standard | `string` | `"pd-standard"` | no |
| ephemeral\_ip | Set to true if an ephemeral external IP/DNS is required, must also set access\_config if true | `bool` | `false` | no |
| labels | Key-value map of labels to assign to the bastion host | `map(string)` | n/a | yes |
| machine\_type | Instance type for the Bastion host | `string` | n/a | yes |
| members | List of IAM resources to allow access to the bastion host | `list(string)` | n/a | yes |
| metadata | Key-value map of additional metadata to assign to the instances | `map(string)` | n/a | yes |
| name | Name of the Bastion instance | `string` | n/a | yes |
| network\_name | Name of the VPC | `string` | n/a | yes |
| project | The project in which the resource belongs | `string` | n/a | yes |
| region | The location linked to the project | `string` | n/a | yes |
| scopes | List of scopes to attach to the bastion host | `list(string)` | <pre>[<br>  "cloud-platform"<br>]</pre> | no |
| service\_account\_roles | List of IAM roles to assign to the service account. | `list(string)` | <pre>[<br>  "roles/logging.logWriter",<br>  "roles/monitoring.metricWriter",<br>  "roles/monitoring.viewer",<br>  "roles/compute.osLogin"<br>]</pre> | no |
| shielded\_vm | Enable shielded VM on the bastion host (recommended) | `bool` | `true` | no |
| tags | Network tags, provided as a list | `list(string)` | n/a | yes |
| zone | The primary zone where the bastion host will live | `string` | n/a | yes |

## Outputs

No output.
