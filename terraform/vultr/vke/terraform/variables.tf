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


#######################################################################
# Kubernetes

variable "region" {
  type        = string
  description = "The region your VKE cluster will be deployed in. Currently, supported values are ewr and lax"
  default     = "lax"
}

variable "cluster_name" {
  type        = string
  description = "The cluster name"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "node_quantity" {
  type        = number
  description = "The number of nodes in this node pool."
  default     = 3
}

variable "node_plan" {
  type        = string
  description = "The plan to be used in this node pool"
  default     = "vc2-1c-2gb"
}

variable "node_label" {
  type        = string
  description = "The node label"
}

variable "node_pools" {
  description = "Addons node pools"
  type = list(object({
    quantity = number
    plan     = string
    label    = string
    tag      = string
  }))
  default = []
}
