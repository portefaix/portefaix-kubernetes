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
  type        = string
  description = ""
}

variable "addon_coredns_version" {
  type        = string
  description = ""
}

variable "addon_kube_proxy_version" {
  type        = string
  description = ""
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


#############################################################################
# EBS CSI Driver

variable "ebs_csi_controller_role_name" {
  description = "The name of the EBS CSI driver IAM role"
  type        = string
  default     = "ebs-csi-driver-controller"
}

variable "ebs_csi_controller_role_policy_name_prefix" {
  description = "The prefix of the EBS CSI driver IAM policy"
  default     = "ebs-csi-driver-policy"
  type        = string
}

variable "ebs_csi_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "controller_name" {
  description = "Controller name"
  type        = string
  default     = "ebs-csi-controller"
}

variable "namespace" {
  description = "The K8s namespace for all EBS CSI driver resources"
  type        = string
  default     = "kube-system"
}