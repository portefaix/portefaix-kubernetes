## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | < 5.0.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | < 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster | 22.1.0 |

## Resources

| Name | Type |
|------|------|
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |
| [google_compute_subnetwork.subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |
| [google_pubsub_topic.gke](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/pubsub_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudrun"></a> [cloudrun](#input\_cloudrun) | (Beta) Enable CloudRun addon | `bool` | n/a | yes |
| <a name="input_cluster_autoscaling"></a> [cluster\_autoscaling](#input\_cluster\_autoscaling) | Cluster autoscaling configuration. See [more details](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling) | <pre>object({<br>    enabled             = bool<br>    autoscaling_profile = string<br>    min_cpu_cores       = number<br>    max_cpu_cores       = number<br>    min_memory_gb       = number<br>    max_memory_gb       = number<br>    gpu_resources       = list(object({ resource_type = string, minimum = number, maximum = number }))<br>  })</pre> | <pre>{<br>  "autoscaling_profile": "BALANCED",<br>  "enabled": false,<br>  "gpu_resources": [],<br>  "max_cpu_cores": 0,<br>  "max_memory_gb": 0,<br>  "min_cpu_cores": 0,<br>  "min_memory_gb": 0<br>}</pre> | no |
| <a name="input_cluster_resource_labels"></a> [cluster\_resource\_labels](#input\_cluster\_resource\_labels) | The GCE resource labels (a map of key/value pairs) to be applied to the cluster | `map(string)` | `{}` | no |
| <a name="input_config_connector"></a> [config\_connector](#input\_config\_connector) | (Beta) Whether ConfigConnector is enabled for this cluster. | `bool` | n/a | yes |
| <a name="input_create_service_account"></a> [create\_service\_account](#input\_create\_service\_account) | Defines if service account specified to run nodes should be created. | `bool` | n/a | yes |
| <a name="input_datapath_provider"></a> [datapath\_provider](#input\_datapath\_provider) | The desired datapath provider for this cluster. By default, `DATAPATH_PROVIDER_UNSPECIFIED` enables the IPTables-based kube-proxy implementation. `ADVANCED_DATAPATH` enables Dataplane-V2 feature. | `string` | `"DATAPATH_PROVIDER_UNSPECIFIED"` | no |
| <a name="input_default_max_pods_per_node"></a> [default\_max\_pods\_per\_node](#input\_default\_max\_pods\_per\_node) | The maximum number of pods to schedule per node | `number` | `110` | no |
| <a name="input_disable_legacy_metadata_endpoints"></a> [disable\_legacy\_metadata\_endpoints](#input\_disable\_legacy\_metadata\_endpoints) | Disable the /0.1/ and /v1beta1/ metadata server endpoints on the node. Changing this value will cause all node pools to be recreated. | `bool` | `true` | no |
| <a name="input_dns_cache"></a> [dns\_cache](#input\_dns\_cache) | (Beta) The status of the NodeLocal DNSCache addon. | `bool` | n/a | yes |
| <a name="input_enable_binary_authorization"></a> [enable\_binary\_authorization](#input\_enable\_binary\_authorization) | Enable BinAuthZ Admission controller | `bool` | n/a | yes |
| <a name="input_enable_confidential_nodes"></a> [enable\_confidential\_nodes](#input\_enable\_confidential\_nodes) | An optional flag to enable confidential node config. | `bool` | n/a | yes |
| <a name="input_enable_intranode_visibility"></a> [enable\_intranode\_visibility](#input\_enable\_intranode\_visibility) | Whether Intra-node visibility is enabled for this cluster. This makes same node pod to pod traffic visible for VPC network | `bool` | `false` | no |
| <a name="input_enable_kubernetes_alpha"></a> [enable\_kubernetes\_alpha](#input\_enable\_kubernetes\_alpha) | Whether to enable Kubernetes Alpha features for this cluster. Note that when this option is enabled, the cluster cannot be upgraded and will be automatically deleted after 30 days. | `bool` | `false` | no |
| <a name="input_enable_private_nodes"></a> [enable\_private\_nodes](#input\_enable\_private\_nodes) | (Beta) Whether nodes have internal IP addresses only | `bool` | n/a | yes |
| <a name="input_enable_shielded_nodes"></a> [enable\_shielded\_nodes](#input\_enable\_shielded\_nodes) | Enable Shielded Nodes features on all nodes in this cluster | `bool` | n/a | yes |
| <a name="input_enable_tpu"></a> [enable\_tpu](#input\_enable\_tpu) | Enable Cloud TPU resources in the cluster. WARNING: changing this after cluster creation is destructive! | `bool` | `false` | no |
| <a name="input_enable_vertical_pod_autoscaling"></a> [enable\_vertical\_pod\_autoscaling](#input\_enable\_vertical\_pod\_autoscaling) | Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it | `bool` | n/a | yes |
| <a name="input_filestore_csi_driver"></a> [filestore\_csi\_driver](#input\_filestore\_csi\_driver) | The status of the Filestore CSI driver addon, which allows the usage of filestore instance as volumes | `bool` | `false` | no |
| <a name="input_gce_pd_csi_driver"></a> [gce\_pd\_csi\_driver](#input\_gce\_pd\_csi\_driver) | (Beta) Whether this cluster should enable the Google Compute Engine Persistent Disk Container Storage Interface (CSI) Driver. | `bool` | n/a | yes |
| <a name="input_horizontal_pod_autoscaling"></a> [horizontal\_pod\_autoscaling](#input\_horizontal\_pod\_autoscaling) | Enable horizontal pod autoscaling addon | `bool` | n/a | yes |
| <a name="input_http_load_balancing"></a> [http\_load\_balancing](#input\_http\_load\_balancing) | Enable httpload balancer addon | `bool` | n/a | yes |
| <a name="input_identity_namespace"></a> [identity\_namespace](#input\_identity\_namespace) | Workload Identity namespace. (Default value of `enabled` automatically sets project based namespace `[project_id].svc.id.goog`) | `string` | `"enabled"` | no |
| <a name="input_initial_node_count"></a> [initial\_node\_count](#input\_initial\_node\_count) | The number of nodes to create in this cluster's default node pool. | `number` | n/a | yes |
| <a name="input_ip_range_pods"></a> [ip\_range\_pods](#input\_ip\_range\_pods) | The _name_ of the secondary subnet ip range to use for pods | `string` | n/a | yes |
| <a name="input_ip_range_services"></a> [ip\_range\_services](#input\_ip\_range\_services) | The _name_ of the secondary subnet range to use for services | `string` | n/a | yes |
| <a name="input_istio"></a> [istio](#input\_istio) | (Beta) Enable Istio addon | `bool` | n/a | yes |
| <a name="input_logging_service"></a> [logging\_service](#input\_logging\_service) | The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none | `string` | n/a | yes |
| <a name="input_maintenance_end_time"></a> [maintenance\_end\_time](#input\_maintenance\_end\_time) | Time window specified for recurring maintenance operations in RFC3339 format | `string` | n/a | yes |
| <a name="input_maintenance_exclusions"></a> [maintenance\_exclusions](#input\_maintenance\_exclusions) | List of maintenance exclusions. A cluster can have up to three | `list(object({ name = string, start_time = string, end_time = string, exclusion_scope = string }))` | `[]` | no |
| <a name="input_maintenance_recurrence"></a> [maintenance\_recurrence](#input\_maintenance\_recurrence) | Frequency of the recurring maintenance window in RFC5545 format. | `string` | n/a | yes |
| <a name="input_maintenance_start_time"></a> [maintenance\_start\_time](#input\_maintenance\_start\_time) | Time window specified for daily or recurring maintenance operations in RFC3339 format | `string` | n/a | yes |
| <a name="input_master_authorized_networks"></a> [master\_authorized\_networks](#input\_master\_authorized\_networks) | List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists). | `list(object({ cidr_block = string, display_name = string }))` | n/a | yes |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | (Beta) The IP range in CIDR notation to use for the hosted master network | `string` | `"10.0.0.0/28"` | no |
| <a name="input_monitoring_enable_managed_prometheus"></a> [monitoring\_enable\_managed\_prometheus](#input\_monitoring\_enable\_managed\_prometheus) | Configuration for Managed Service for Prometheus. Whether or not the managed collection is enabled. | `bool` | `false` | no |
| <a name="input_monitoring_service"></a> [monitoring\_service](#input\_monitoring\_service) | The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the cluster (required) | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the VPC | `string` | n/a | yes |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | Enable network policy addon | `bool` | n/a | yes |
| <a name="input_network_policy_provider"></a> [network\_policy\_provider](#input\_network\_policy\_provider) | The network policy provider. | `string` | `"CALICO"` | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | List of maps containing node pools | `list(map(string))` | <pre>[<br>  {<br>    "name": "main"<br>  }<br>]</pre> | no |
| <a name="input_node_pools_labels"></a> [node\_pools\_labels](#input\_node\_pools\_labels) | Map of maps containing node labels by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "main": {}<br>}</pre> | no |
| <a name="input_node_pools_metadata"></a> [node\_pools\_metadata](#input\_node\_pools\_metadata) | Map of maps containing node metadata by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "main": {}<br>}</pre> | no |
| <a name="input_node_pools_oauth_scopes"></a> [node\_pools\_oauth\_scopes](#input\_node\_pools\_oauth\_scopes) | Map of lists containing node oauth scopes by node-pool name | `map(list(string))` | <pre>{<br>  "all": [<br>    "https://www.googleapis.com/auth/cloud-platform"<br>  ],<br>  "main": []<br>}</pre> | no |
| <a name="input_node_pools_tags"></a> [node\_pools\_tags](#input\_node\_pools\_tags) | Map of lists containing node network tags by node-pool name | `map(list(string))` | <pre>{<br>  "all": [],<br>  "main": []<br>}</pre> | no |
| <a name="input_node_pools_taints"></a> [node\_pools\_taints](#input\_node\_pools\_taints) | Map of lists containing node taints by node-pool name | `map(list(object({ key = string, value = string, effect = string })))` | <pre>{<br>  "all": [],<br>  "main": []<br>}</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | The project in which the resource belongs | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region in which the cluster should be created. | `string` | n/a | yes |
| <a name="input_regional"></a> [regional](#input\_regional) | Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!) | `bool` | n/a | yes |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `UNSPECIFIED`. | `string` | n/a | yes |
| <a name="input_remove_default_node_pool"></a> [remove\_default\_node\_pool](#input\_remove\_default\_node\_pool) | Remove default node pool while setting up the cluster | `bool` | n/a | yes |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | The Pub/Sub topic name for GKE updates | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | The zones to host the cluster in (optional if regional cluster / required if zonal) | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
