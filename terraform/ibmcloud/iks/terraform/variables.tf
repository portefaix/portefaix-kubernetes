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

#######################################################################
# IKS

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC to used."
  type        = string
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "kube_version" {
  description = "The Kubernetes or OpenShift version that you want to set up in your cluster."
  type        = string
  default     = null
}

variable "worker_pool_flavor" {
  description = " The flavor of the VPC worker node that you want to use."
  type        = string
}

# variable "update_all_workers" {
#   description = "set to true, the Kubernetes version of the worker nodes is updated along with the Kubernetes version of the cluster that you specify in kube_version."
#   type        = bool
#   default     = false
# }

variable "service_subnet" {
  description = "Specify a custom subnet CIDR to provide private IP addresses for services."
  type        = string
  default     = null
}

variable "pod_subnet" {
  description = "Specify a custom subnet CIDR to provide private IP addresses for pods."
  type        = string
  default     = null
}

variable "worker_nodes_per_zone" {
  description = "The number of worker nodes per zone in the default worker pool."
  type        = number
  default     = 1
}

variable "worker_labels" {
  description = "Labels on all the workers in the default worker pool."
  type        = map(string)
}

# variable "wait_till" {
#   description = "specify the stage when Terraform to mark the cluster creation as completed."
#   type        = string
#   default     = "ingressReady"
# }

# variable "disable_public_service_endpoint" {
#   description = "Boolean value true if Public service endpoint to be disabled."
#   type        = bool
#   default     = false
# }

variable "tags" {
  description = "List of tags."
  type        = list(string)
  default     = ["terraform", "iks", "kubernetes"]
}

variable "cos_instance_crn" {
  description = "Enable openshift entitlement during cluster creation ."
  type        = string
  default     = null
}

# variable "force_delete_storage" {
#   description = "force the removal of persistent storage associated with the cluster during cluster deletion."
#   type        = bool
#   default     = false
# }

# variable "worker_zones" {
#   type    = map
# }

# variable "kms_config" {
#   type    = list(map(string))
#   default = []
# }

# variable "create_timeout" {
#   type        = string
#   description = "Timeout duration for create."
#   default     = null
# }

# variable "update_timeout" {
#   type        = string
#   description = "Timeout duration for update."
#   default     = null
# }

# variable "delete_timeout" {
#   type        = string
#   description = "Timeout duration for delete."
#   default     = null
# }

variable "taints" {
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  description = "Set taints to worker nodes."
  default     = null
}

############################################################################
# Node Pools

variable "node_pools" {
  description = "List of maps containing node pools"
  type = list(object({
    name           = string
    nodes_per_zone = number
    flavor         = string
    labels         = map(string)
    taints = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
  default = []
}

############################################################################
# ALB

variable "alb_enable" {
  description = "If set to true, the default Ingress ALB in your cluster is enabled and configured with the IBM-provided Ingress subdomain. If set to false, the default Ingress ALB is disabled in your cluster. "
  type        = bool
  default     = true
}
