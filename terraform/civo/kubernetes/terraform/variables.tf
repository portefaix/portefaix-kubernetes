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
  description = "The region in which the cluster should be created."
}

#######################################################################
# Kubernetes

variable "cluster_name" {
  type        = string
  description = "name of the kubernetes cluster"
}

variable "node_count" {
  type        = number
  description = "Number of nodes into the cluster"
}

variable "node_instance_size" {
  type        = string
  description = "Instance type of the target nodes."
  default     = "g3.k3s.medium"
}

variable "cni" {
  type        = string
  description = "The cni for the k3s to install"
  default     = "cilium"
}

variable "k3s_version" {
  type        = string
  description = "supported version of the k3s cluster"
  default     = ""
}

variable "network_name" {
  type        = string
  description = "name of the existing network"
  default     = ""
}

variable "authorized_networks" {
  type        = set(string)
  description = "Authorized networks for Kubernetes API server"
  # default     = ["0.0.0.0/0"]
}

variable "tags" {
  type        = string
  description = "Tags"
  default     = "terraform"
}

variable "node_pools" {
  description = "Addons node pools"
  type = list(object({
    label      = string
    node_count = number
    size       = string
    region     = string
  }))
  default = []
}
