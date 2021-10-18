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

#############################################################################
# Provider

variable "region" {
  type        = string
  description = "AWS Region"
}

#############################################################################
# Networking

variable "vpc_name" {
  type        = string
  description = "ID of the VPC"
}

#############################################################################
# Kubernetes cluster


variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "cluster_version" {
  type        = string
  description = "The EKS Kubernetes version"
}

variable "tags" {
  description = "A map of tags to add to all resources. Tags added to launch configuration or templates override these values for ASG Tags only."
  type        = map(string)
  default = {
    "made-by" = "terraform"
  }
}

variable "cluster_tags" {
  description = "A map of tags to add to just the eks resource."
  type        = map(string)
  default = {
    "made-by" = "terraform"
  }
}

variable "node_groups_defaults" {
  description = "Map of values to be applied to all node groups. See `node_groups` module's documentation for more details"
  type        = any
}

variable "node_groups" {
  description = "Map of map of node groups to create. See `node_groups` module's documentation for more details"
  type        = any
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

#############################################################################
# Addons
variable "addon_vpc_cni_version" {
  type    = string
  default = ""
}

variable "addon_coredns_version" {
  type    = string
  default = ""
}

variable "addon_kube_proxy_version" {
  type    = string
  default = ""
}

#############################################################################
# Monitoring

variable "enabled_logs" {
  type    = list
  default = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "log_retention" {
  type        = number
  default     = 7
  description = "Days of log retention in cloudwatch"
}