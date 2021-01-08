# Copyright (C) 2020-2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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



#############################################################################
# Networking

variable "vswitch_name" {
  type        = string
  description = "Name of the vswitch"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

#############################################################################
# Kubernetes cluster

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "The ACK Kubernetes version"
}

variable "tags" {
  type        = map(string)
  description = "Tags associated to the resources"
  default = {
    "made-by" = "terraform"
  }
}

variable "enable_ssh" {
  type        = bool
  description = "Enable login to the node through SSH"
}

variable "node_cidr_mask" {
  type        = string
  description = "The node cidr block to specific how many pods can run on single node"
}

variable "slb_internet_enabled" {
  type        = bool
  description = "Whether to create internet load balancer for API Server"
}

variable "worker_instance_types" {
  description = "The ecs instance type used to launch worker nodes"
  type        = list(string)
}

variable "worker_disk_category" {
  description = "The system disk category used to launch one or more worker nodes."
  type        = string
}

variable "worker_disk_size" {
  description = "The system disk size used to launch one or more worker nodes."
  type        = number
}

variable "worker_number" {
  description = "The number of kubernetes cluster work nodes."
  type        = number
}

variable "pod_cidr" {
  description = "The kubernetes pod cidr block. It cannot be equals to vpc's or vswitch's and cannot be in them. If vpc's cidr block is `172.16.XX.XX/XX`, it had better to `192.168.XX.XX/XX` or `10.XX.XX.XX/XX`."
  type        = string
}

variable "service_cidr" {
  description = "The kubernetes service cidr block. It cannot be equals to vpc's or vswitch's or pod's and cannot be in them. Its setting rule is same as `k8s_pod_cidr`."
  type        = string
}

variable "cluster_addons" {
  type = list(object({
    name      = string
    config    = string
  }))

  default = []
}

#############################################################################
# Addons node pool



#############################################################################
# 