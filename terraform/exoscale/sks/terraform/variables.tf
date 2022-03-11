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
# SKS

variable "name" {
  description = "The name of the SKS cluster."
  type        = string
}

variable "zone" {
  description = "The name of the zone to deploy the SKS cluster into."
  type        = string
}

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version of the SKS cluster control plane"
}

variable "service_level" {
  type        = string
  description = "The service level of the SKS cluster control plane"
}

variable "cni" {
  type        = string
  description = "The Kubernetes CNI plugin to be deployed in the SKS cluster control plane"
}

variable "exoscale_ccm" {
  type        = bool
  description = "Deploy the Exoscale Cloud Controller Manager in the SKS cluster control plane_"
}

variable "metrics_server" {
  type        = bool
  description = "Deploy the Kubernetes Metrics Server in the SKS cluster control plane"
}

variable "auto_upgrade" {
  type        = bool
  description = "Enable automatic upgrading of the SKS cluster control plane Kubernetes version"
}

variable "node_pools" {
  description = "The SKS node pools to create."
  type = list(object({
    name          = string
    instance_type = string
    size          = number
  }))
  default = []
}
