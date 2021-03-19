# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

#####################################################################""
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
# Kubernetes

variable "location" {
  type        = string
  description = "The location of the cluster"
}

variable "name" {
  description = "Cluster name"
  type        = string
}

# variable network {
#   type        = string
#   description = "Name of the network to use"
# }

# variable subnet_network {
#   type        = string
#   description = "Name of the subnet to use"
# }

variable "release_channel" {
  description = "Release cadence of the GKE cluster"
  type        = string
}

variable "network_config" {
  description = "VPC network configuration for the cluster"
  type        = map(any)
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "The IP range in CIDR notation to use for the hosted master network"
}

variable "master_authorized_networks" {
  type        = list(object({ cidr_block = string, display_name = string }))
  description = "List of master authorized networks"
  # default = [
  #   {
  #     cidr_block   = "0.0.0.0/0"
  #     display_name = "internet"
  #   }
  # ]
}

variable "labels" {
  description = "List of Kubernetes labels to apply to the nodes"
  type        = map(any)
}

variable "rbac_group_domain" {
  description = "Google Groups for RBAC requires a G Suite domain"
  type        = string
  default     = ""
}

variable "network_policy" {
  description = "Enable Network Policy"
  type        = bool
  default     = true
}

variable "auto_scaling" {
  description = "Enable cluster autoscaling"
  type        = bool
}

variable "hpa" {
  description = "Enable Horizontal Pod Autoscaling"
  type        = bool
}

variable "datapath_provider" {
  description = "The desired datapath provider for this cluster"
  type        = string
}

variable "pod_security_policy" {
  description = "Enable Pod Security Policy"
  type        = bool
  default     = true
}

variable "monitoring_service" {
  description = "Enable monitoring Service"
  type        = bool
  default     = true
}

variable "logging_service" {
  description = "Enable logging Service"
  type        = bool
  default     = true
}

variable "binary_authorization" {
  description = "Enable Binary Authorization"
  type        = bool
  default     = true
}

variable "google_cloud_load_balancer" {
  description = "Enable Google load balancer"
  type        = bool
}

variable "istio" {
  description = "Enable Istio"
  type        = bool
}

variable "cloudrun" {
  description = "Enable Cloud Run on GKE (requires istio)"
  type        = bool
}

variable "csi_driver" {
  description = "Enable Google Compute Engine Persistent Disk Container Storage Interface (CSI) Driver"
  type        = bool
}

variable "config_connector" {
  description = "Enable the ConfigConnector addon"
  type        = bool
}

variable "maintenance_start_time" {
  description = "Time window specified for daily or recurring maintenance operations in RFC3339 format"
  type        = string
  default     = "03:00"
}

variable "auto_scaling_max_cpu" {
  type        = number
  description = "Maximum amount of CPU in the cluster"
  default     = 10
}

variable "auto_scaling_min_cpu" {
  type        = number
  description = "Minimum amount of CPU in the cluster"
  default     = 5
}

variable "auto_scaling_max_mem" {
  type        = number
  description = "Maximum amount of Memory in the cluster."
  default     = 20
}

variable "auto_scaling_min_mem" {
  type        = number
  description = "Minimum amount of Memory in the cluster"
  default     = 5
}

variable "default_max_pods_per_node" {
  type        = number
  description = "The default maximum number of pods per node in this cluster."
}

#####################################################################""
# Kubernetes node pool

variable "oauth_scopes" {
  type        = list(string)
  description = "Other oauth scopes to add to the node pools"
  default     = []
}

variable "auto_upgrade" {
  type        = bool
  description = "Whether the nodes will be automatically upgraded"
}

variable "auto_repair" {
  type        = bool
  description = "Whether the nodes will be automatically repaired"
}

variable "node_metadata" {
  type        = string
  description = "How to expose the node metadata to the workload running on the node."
  default     = "GKE_METADATA_SERVER"
}

variable "image_type" {
  description = "The image type to use for the node(s)"
  type        = string
  default     = "COS_CONTAINERD"
}

variable "node_labels" {
  type        = map(any)
  description = "Map of labels apply to nodes"
}

variable "node_tags" {
  type        = list(string)
  description = "List of labels apply to nodes"
}

#######################################################################
# Node pools addons

variable "node_pools" {
  description = "Addons node pools"
  type = list(object({
    name                    = string
    default_service_account = string
    node_count              = number
    min_node_count          = number
    max_node_count          = number
    machine_type            = string
    disk_size_gb            = number
    max_pods_per_node       = number
    preemptible             = bool
    taints                  = list(map(string))
  }))
  default = []
}
