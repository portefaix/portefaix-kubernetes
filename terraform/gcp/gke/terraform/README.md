## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| google | 3.74.0 |
| google-beta | 3.74.0 |

## Providers

| Name | Version |
|------|---------|
| google | 3.74.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| gke | nlamirault/gke/google | 0.8.0 |

## Resources

| Name |
|------|
| [google_compute_network](https://registry.terraform.io/providers/hashicorp/google/3.74.0/docs/data-sources/compute_network) |
| [google_compute_subnetwork](https://registry.terraform.io/providers/hashicorp/google/3.74.0/docs/data-sources/compute_subnetwork) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| auto\_repair | Whether the nodes will be automatically repaired | `bool` | n/a | yes |
| auto\_scaling | Enable cluster autoscaling | `bool` | n/a | yes |
| auto\_scaling\_max\_cpu | Maximum amount of CPU in the cluster | `number` | `10` | no |
| auto\_scaling\_max\_mem | Maximum amount of Memory in the cluster. | `number` | `20` | no |
| auto\_scaling\_min\_cpu | Minimum amount of CPU in the cluster | `number` | `5` | no |
| auto\_scaling\_min\_mem | Minimum amount of Memory in the cluster | `number` | `5` | no |
| auto\_upgrade | Whether the nodes will be automatically upgraded | `bool` | n/a | yes |
| binary\_authorization | Enable Binary Authorization | `bool` | `true` | no |
| cloudrun | Enable Cloud Run on GKE (requires istio) | `bool` | n/a | yes |
| config\_connector | Enable the ConfigConnector addon | `bool` | n/a | yes |
| csi\_driver | Enable Google Compute Engine Persistent Disk Container Storage Interface (CSI) Driver | `bool` | n/a | yes |
| datapath\_provider | The desired datapath provider for this cluster | `string` | n/a | yes |
| default\_max\_pods\_per\_node | The default maximum number of pods per node in this cluster. | `number` | n/a | yes |
| dns\_cache | Enable the NodeLocal DNSCache addon | `bool` | n/a | yes |
| google\_cloud\_load\_balancer | Enable Google load balancer | `bool` | n/a | yes |
| hpa | Enable Horizontal Pod Autoscaling | `bool` | n/a | yes |
| image\_type | The image type to use for the node(s) | `string` | `"COS_CONTAINERD"` | no |
| istio | Enable Istio | `bool` | n/a | yes |
| labels | List of Kubernetes labels to apply to the nodes | `map(any)` | n/a | yes |
| location | The location of the cluster | `string` | n/a | yes |
| logging\_service | Enable logging Service | `bool` | `true` | no |
| maintenance\_end\_time | Time window specified for recurring maintenance operations in RFC3339 format | `string` | `"06:00"` | no |
| maintenance\_exclusions | List of maintenance exclusions. A cluster can have up to three | <pre>list(object({<br>    name       = string,<br>    start_time = string,<br>    end_time   = string<br>  }))</pre> | <pre>[<br>  {<br>    "end_time": "2021-05-21T23:59:00Z",<br>    "name": "Data Job",<br>    "start_time": "2021-05-21T00:00:00Z"<br>  },<br>  {<br>    "end_time": "2022-01-02T23:59:00Z",<br>    "name": "Happy new year",<br>    "start_time": "2022-01-01T00:00:00Z"<br>  }<br>]</pre> | no |
| maintenance\_recurrence | Frequency of the recurring maintenance window in RFC5545 format. | `string` | `""` | no |
| maintenance\_start\_time | Time window specified for daily or recurring maintenance operations in RFC3339 format | `string` | `"02:00"` | no |
| master\_authorized\_networks | List of master authorized networks | `list(object({ cidr_block = string, display_name = string }))` | n/a | yes |
| master\_ipv4\_cidr\_block | The IP range in CIDR notation to use for the hosted master network | `string` | n/a | yes |
| monitoring\_service | Enable monitoring Service | `bool` | `true` | no |
| name | Cluster name | `string` | n/a | yes |
| network\_config | VPC network configuration for the cluster | `map(any)` | n/a | yes |
| network\_name | Name of the VPC | `string` | n/a | yes |
| network\_policy | Enable Network Policy | `bool` | `true` | no |
| node\_labels | Map of labels apply to nodes | `map(any)` | n/a | yes |
| node\_metadata | How to expose the node metadata to the workload running on the node. | `string` | `"GKE_METADATA_SERVER"` | no |
| node\_pools | Addons node pools | <pre>list(object({<br>    name                    = string<br>    default_service_account = string<br>    node_count              = number<br>    autoscaling             = bool<br>    min_node_count          = number<br>    max_node_count          = number<br>    machine_type            = string<br>    disk_size_gb            = number<br>    max_pods_per_node       = number<br>    preemptible             = bool<br>    taints                  = list(map(string))<br>  }))</pre> | `[]` | no |
| node\_tags | List of labels apply to nodes | `list(string)` | n/a | yes |
| oauth\_scopes | Other oauth scopes to add to the node pools | `list(string)` | `[]` | no |
| pod\_security\_policy | Enable Pod Security Policy | `bool` | `true` | no |
| project | The project in which the resource belongs | `string` | n/a | yes |
| region | The region in which the cluster should be created. | `string` | n/a | yes |
| release\_channel | Release cadence of the GKE cluster | `string` | n/a | yes |
| shielded\_nodes | Enable Shielded Nodes features on all nodes in this cluster | `bool` | n/a | yes |

## Outputs

No output.
