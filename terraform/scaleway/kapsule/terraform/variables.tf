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

#######################################################################
# Provider

variable "region" {
  type        = string
  description = "The region that will be used as default value for all resources."
}

variable "zone" {
  type        = string
  description = "The zone that will be used as default value for all resources"
}

#######################################################################
# Kubernetes cluster

variable "name" {
  description = "The name of the cluster"
  type        = string
}

variable "description" {
  description = "Description of the cluster"
  type        = string
}

variable "k8s_version" {
  type        = string
  description = "The version of the Kubernetes cluster."
}

variable "cni" {
  type        = string
  default     = "cilium"
  description = "The Container Network Interface (CNI) for the Kubernetes cluster."

  validation {
    condition     = contains(["cilium", "weave", "calico", "flannel"], var.cni)
    error_message = "Values can only be \"cilium\", \"weave\", \"calico\" or \"flannel\"."
  }
}

variable "tags" {
  type        = list(string)
  default     = []
  description = "The tags associated with the Kubernetes cluster."
}

variable "feature_gates" {
  default     = []
  type        = list(string)
  description = "The list of feature gates to enable on the cluster."
}

variable "admission_plugins" {
  default     = []
  type        = list(string)
  description = "The list of admission plugins to enable on the cluster."
}


variable "enable_cluster_autoscaler" {
  default     = false
  type        = bool
  description = "(Optional) Enables the Kubernetes cluster autoscaler."
}

variable "disable_scale_down" {
  default     = false
  type        = bool
  description = "(Defaults to false) Disables the scale down feature of the autoscaler."
}

variable "scale_down_delay_after_add" {
  default     = "10m"
  type        = string
  description = "(Defaults to 10m) How long after scale up that scale down evaluation resumes."
}

variable "scale_down_unneeded_time" {
  default     = "10m"
  type        = string
  description = "(Default to 10m) How long a node should be unneeded before it is eligible for scale down."
}

variable "estimator" {
  default     = "binpacking"
  type        = string
  description = "(Defaults to binpacking) Type of resource estimator to be used in scale up."
}

variable "expander" {
  default     = "random"
  type        = string
  description = "(Default to random) Type of node group expander to be used in scale up."
}

variable "ignore_daemonsets_utilization" {
  default     = false
  type        = bool
  description = "(Defaults to false) Ignore DaemonSet pods when calculating resource utilization for scaling down."
}

variable "balance_similar_node_groups" {
  default     = false
  type        = bool
  description = "(Defaults to false) Detect similar node groups and balance the number of nodes between them."
}

variable "expendable_pods_priority_cutoff" {
  default     = "-10"
  type        = string
  description = "(Defaults to -10) Pods with priority below cutoff will be expendable. They can be killed without any consideration during scale down and they don't cause scale up. Pods with null priority (PodPriority disabled) are non expendable."
}

variable "enable_auto_upgrade" {
  default     = false
  type        = bool
  description = "(Optional) Set to true to enable Kubernetes patch version auto upgrades. ~> Important: When enabling auto upgrades, the version field take a minor version like x.y (ie 1.18)."
}

variable "maintenance_window_start_hour" {
  default     = null
  type        = string
  description = "(Optional) The start hour (UTC) of the 2-hour auto upgrade maintenance window (0 to 23). Required if enable_auto_upgrade is true"
}

variable "maintenance_window_day" {
  default     = null
  type        = string
  description = "(Optional) The day of the auto upgrade maintenance window (monday to sunday, or any). Required if enable_auto_upgrade is true"
}

#######################################################################
# Node pools

variable "node_pools" {
  description = "Node pools configuration for Kubernetes cluster."
  type = map(object({
    node_type           = string
    size                = number
    min_size            = number
    max_size            = number
    autoscaling         = bool
    autohealing         = bool
    wait_for_pool_ready = bool
    tags                = list(string)
  }))
  default = {}
}
