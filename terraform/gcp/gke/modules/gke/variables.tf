# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

############################################################################
# Provider

variable "project" {
  type        = string
  description = "The project in which the resource belongs"
}

variable "region" {
  type        = string
  description = "The region in which the cluster should be created."
}

############################################################################
# VPC

variable "network_name" {
  type        = string
  description = "Name of the VPC"
}

############################################################################
# Bastion

# variable "bastion_ip_address_name" {
#   type        = string
#   description = "Name of the Bastion IP address"
# }


############################################################################
# PubSub

variable "topic_name" {
  type        = string
  description = "The Pub/Sub topic name for GKE updates"
}

############################################################################
# Kubernetes

variable "name" {
  type        = string
  description = "The name of the cluster (required)"
}

variable "regional" {
  type        = bool
  description = "Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!)"
}

#variable "location" {
#  type        = string
#  description = "The region to host the cluster in (optional if zonal cluster / required if regional)"
#}

variable "zones" {
  type        = list(string)
  description = "The zones to host the cluster in (optional if regional cluster / required if zonal)"
}

variable "master_authorized_networks" {
  type        = list(object({ cidr_block = string, display_name = string }))
  description = "List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists)."
}

variable "enable_vertical_pod_autoscaling" {
  type        = bool
  description = "Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it"
}

variable "horizontal_pod_autoscaling" {
  type        = bool
  description = "Enable horizontal pod autoscaling addon"
}

variable "http_load_balancing" {
  type        = bool
  description = "Enable httpload balancer addon"
}

variable "network_policy" {
  type        = bool
  description = "Enable network policy addon"
}

variable "network_policy_provider" {
  type        = string
  description = "The network policy provider."
  default     = "CALICO"
}
variable "datapath_provider" {
  type        = string
  description = "The desired datapath provider for this cluster. By default, `DATAPATH_PROVIDER_UNSPECIFIED` enables the IPTables-based kube-proxy implementation. `ADVANCED_DATAPATH` enables Dataplane-V2 feature."
  default     = "DATAPATH_PROVIDER_UNSPECIFIED"
}

variable "maintenance_start_time" {
  type        = string
  description = "Time window specified for daily or recurring maintenance operations in RFC3339 format"
}

variable "maintenance_exclusions" {
  type        = list(object({ name = string, start_time = string, end_time = string, exclusion_scope = string }))
  description = "List of maintenance exclusions. A cluster can have up to three"
  default     = []
}

variable "maintenance_end_time" {
  type        = string
  description = "Time window specified for recurring maintenance operations in RFC3339 format"
}

variable "maintenance_recurrence" {
  type        = string
  description = "Frequency of the recurring maintenance window in RFC5545 format."
}

variable "ip_range_pods" {
  type        = string
  description = "The _name_ of the secondary subnet ip range to use for pods"
}

variable "ip_range_services" {
  type        = string
  description = "The _name_ of the secondary subnet range to use for services"
}

variable "initial_node_count" {
  type        = number
  description = "The number of nodes to create in this cluster's default node pool."
}

variable "remove_default_node_pool" {
  type        = bool
  description = "Remove default node pool while setting up the cluster"
}

variable "disable_legacy_metadata_endpoints" {
  type        = bool
  description = "Disable the /0.1/ and /v1beta1/ metadata server endpoints on the node. Changing this value will cause all node pools to be recreated."
  default     = true
}

variable "enable_kubernetes_alpha" {
  type        = bool
  description = "Whether to enable Kubernetes Alpha features for this cluster. Note that when this option is enabled, the cluster cannot be upgraded and will be automatically deleted after 30 days."
  default     = false
}

variable "cluster_autoscaling" {
  type = object({
    enabled             = bool
    autoscaling_profile = string
    min_cpu_cores       = number
    max_cpu_cores       = number
    min_memory_gb       = number
    max_memory_gb       = number
    gpu_resources       = list(object({ resource_type = string, minimum = number, maximum = number }))
  })
  default = {
    enabled             = false
    autoscaling_profile = "BALANCED"
    max_cpu_cores       = 0
    min_cpu_cores       = 0
    max_memory_gb       = 0
    min_memory_gb       = 0
    gpu_resources       = []
  }
  description = "Cluster autoscaling configuration. See [more details](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling)"
}

variable "logging_service" {
  type        = string
  description = "The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none"
}

variable "monitoring_service" {
  type        = string
  description = "The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none"
}

variable "create_service_account" {
  type        = bool
  description = "Defines if service account specified to run nodes should be created."
}

# variable "grant_registry_access" {
#   type        = bool
#   description = "Grants created cluster-specific service account storage.objectViewer role."
#   default     = false
# }

# variable "registry_project_ids" {
#   type        = list(string)
#   description = "Projects holding Google Container Registries. If empty, we use the cluster project. If a service account is created and the `grant_registry_access` variable is set to `true`, the `storage.objectViewer` role is assigned on these projects."
#   default     = []
# }

# variable "service_account" {
#   type        = string
#   description = "The service account to run nodes as if not overridden in `node_pools`. The create_service_account variable default value (true) will cause a cluster-specific service account to be created."
#   default     = ""
# }

# variable "cluster_ipv4_cidr" {
#   default     = null
#   description = "The IP address range of the kubernetes pods in this cluster. Default is an automatically assigned CIDR."
# }

variable "cluster_resource_labels" {
  type        = map(string)
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster"
  default     = {}
}

variable "default_max_pods_per_node" {
  description = "The maximum number of pods to schedule per node"
  type        = number
  default     = 110
}

variable "enable_private_nodes" {
  type        = bool
  description = "(Beta) Whether nodes have internal IP addresses only"
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "(Beta) The IP range in CIDR notation to use for the hosted master network"
  default     = "10.0.0.0/28"
}

# variable "master_global_access_enabled" {
#   type        = bool
#   description = "(Beta) Whether the cluster master is accessible globally (from any region) or only within the same region as the private endpoint."

#   default = true
# }


variable "istio" {
  type        = bool
  description = "(Beta) Enable Istio addon"
}

# variable "istio_auth" {
#   type        = string
#   description = "(Beta) The authentication type between services in Istio."
#   default     = "AUTH_MUTUAL_TLS"
# }

variable "dns_cache" {
  type        = bool
  description = "(Beta) The status of the NodeLocal DNSCache addon."
}

variable "gce_pd_csi_driver" {
  type        = bool
  description = "(Beta) Whether this cluster should enable the Google Compute Engine Persistent Disk Container Storage Interface (CSI) Driver."
}

# variable "kalm_config" {
#   type        = bool
#   description = "(Beta) Whether KALM is enabled for this cluster."
#   default     = false
# }

variable "config_connector" {
  type        = bool
  description = "(Beta) Whether ConfigConnector is enabled for this cluster."
}

variable "cloudrun" {
  type        = bool
  description = "(Beta) Enable CloudRun addon"
}

# variable "cloudrun_load_balancer_type" {
#   type        = string
#   description = "(Beta) Configure the Cloud Run load balancer type. External by default. Set to `LOAD_BALANCER_TYPE_INTERNAL` to configure as an internal load balancer."
#   default     = ""
# }

# variable "enable_pod_security_policy" {
#   type        = bool
#   description = "enabled - Enable the PodSecurityPolicy controller for this cluster. If enabled, pods must be valid under a PodSecurityPolicy to be created."
#   default     = false
# }

# variable "enable_l4_ilb_subsetting" {
#   type        = bool
#   description = "Enable L4 ILB Subsetting on the cluster"
#   default     = false
# }

# variable "sandbox_enabled" {
#   type        = bool
#   description = "(Beta) Enable GKE Sandbox (Do not forget to set `image_type` = `COS_CONTAINERD` to use it)."
#   default     = false
# }

variable "enable_intranode_visibility" {
  type        = bool
  description = "Whether Intra-node visibility is enabled for this cluster. This makes same node pod to pod traffic visible for VPC network"
  default     = false
}

# variable "authenticator_security_group" {
#   type        = string
#   description = "The name of the RBAC security group for use with Google security groups in Kubernetes RBAC. Group name must be in format gke-security-groups@yourdomain.com"
#   default     = null
# }

# variable "node_metadata" {
#   description = "Specifies how node metadata is exposed to the workload running on the node"
#   default     = "GKE_METADATA_SERVER"
#   type        = string
# }

# variable "database_encryption" {
#   description = "Application-layer Secrets Encryption settings. The object format is {state = string, key_name = string}. Valid values of state are: \"ENCRYPTED\"; \"DECRYPTED\". key_name is the name of a CloudKMS key."
#   type        = list(object({ state = string, key_name = string }))

#   default = [{
#     state    = "DECRYPTED"
#     key_name = ""
#   }]
# }

variable "identity_namespace" {
  description = "Workload Identity namespace. (Default value of `enabled` automatically sets project based namespace `[project_id].svc.id.goog`)"
  type        = string
  default     = "enabled"
}

variable "release_channel" {
  type        = string
  description = "The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `UNSPECIFIED`."
}

variable "enable_shielded_nodes" {
  type        = bool
  description = "Enable Shielded Nodes features on all nodes in this cluster"
}

variable "enable_binary_authorization" {
  type        = bool
  description = "Enable BinAuthZ Admission controller"
}

# variable "add_cluster_firewall_rules" {
#   type        = bool
#   description = "Create additional firewall rules"
#   default     = false
# }

# variable "add_master_webhook_firewall_rules" {
#   type        = bool
#   description = "Create master_webhook firewall rules for ports defined in `firewall_inbound_ports`"
#   default     = false
# }

# variable "firewall_priority" {
#   type        = number
#   description = "Priority rule for firewall rules"
#   default     = 1000
# }

# variable "firewall_inbound_ports" {
#   type        = list(string)
#   description = "List of TCP ports for admission/webhook controllers. Either flag `add_master_webhook_firewall_rules` or `add_cluster_firewall_rules` (also adds egress rules) must be set to `true` for inbound-ports firewall rules to be applied."
#   default     = ["8443", "9443", "15017"]
# }

# variable "gcloud_upgrade" {
#   type        = bool
#   description = "Whether to upgrade gcloud at runtime"
#   default     = false
# }

# variable "add_shadow_firewall_rules" {
#   type        = bool
#   description = "Create GKE shadow firewall (the same as default firewall rules with firewall logs enabled)."
#   default     = false
# }

# variable "shadow_firewall_rules_priority" {
#   type        = number
#   description = "The firewall priority of GKE shadow firewall rules. The priority should be less than default firewall, which is 1000."
#   default     = 999
# }

# variable "disable_default_snat" {
#   type        = bool
#   description = "Whether to disable the default SNAT to support the private use of public IP addresses"
#   default     = false
# }

# variable "impersonate_service_account" {
#   type        = string
#   description = "An optional service account to impersonate for gcloud commands. If this service account is not specified, the module will use Application Default Credentials."
#   default     = ""
# }

variable "enable_confidential_nodes" {
  type        = bool
  description = "An optional flag to enable confidential node config."
}

# variable "notification_config_topic" {
#   type        = string
#   description = "The desired Pub/Sub topic to which notifications will be sent by GKE. Format is projects/{project}/topics/{topic}."
# }

variable "enable_tpu" {
  type        = bool
  description = "Enable Cloud TPU resources in the cluster. WARNING: changing this after cluster creation is destructive!"
  default     = false
}

variable "filestore_csi_driver" {
  type        = bool
  description = "The status of the Filestore CSI driver addon, which allows the usage of filestore instance as volumes"
  default     = false
}

variable "monitoring_enable_managed_prometheus" {
  type        = bool
  description = "Configuration for Managed Service for Prometheus. Whether or not the managed collection is enabled."
  default     = false
}

############################################################################
# Node Pools

variable "node_pools" {
  type        = list(map(string))
  description = "List of maps containing node pools"
  default = [
    {
      name = "main"
    },
  ]
}


variable "node_pools_labels" {
  type        = map(map(string))
  description = "Map of maps containing node labels by node-pool name"
  default = {
    all  = {}
    main = {}
  }
}

variable "node_pools_metadata" {
  type        = map(map(string))
  description = "Map of maps containing node metadata by node-pool name"
  default = {
    all  = {}
    main = {}
  }
}

variable "node_pools_taints" {
  type        = map(list(object({ key = string, value = string, effect = string })))
  description = "Map of lists containing node taints by node-pool name"
  default = {
    all  = []
    main = []
  }
}

variable "node_pools_tags" {
  type        = map(list(string))
  description = "Map of lists containing node network tags by node-pool name"
  default = {
    all  = []
    main = []
  }
}

variable "node_pools_oauth_scopes" {
  type        = map(list(string))
  description = "Map of lists containing node oauth scopes by node-pool name"
  default = {
    all  = ["https://www.googleapis.com/auth/cloud-platform"]
    main = []
  }
}

# variable "node_pools_linux_node_configs_sysctls" {
#   type        = map(map(string))
#   description = "Map of maps containing linux node config sysctls by node-pool name"

#   # Default is being set in variables_defaults.tf
#   default = {
#     all               = {}
#     default-node-pool = {}
#   }
# }
