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

# variable "region" {
#   type        = string
#   description = "Alicloud Region"
# }

#############################################################################
# ACK

variable "cluster_name" {
  description = "The name prefix used to create managed kubernetes cluster."
  type        = string
  default     = "terraform-alicloud-managed-kubernetes"
}

variable "cpu_core_count" {
  description = "CPU core count is used to fetch instance types."
  type        = number
  default     = 1
}

variable "memory_size" {
  description = "Memory size used to fetch instance types."
  type        = number
  default     = 2
}

variable "kubernetes_version" {
  description = "Desired Kubernetes version"
  type        = string
}

variable "worker_instance_types" {
  description = "The ecs instance type used to launch worker nodes. If not set, data source `alicloud_instance_types` will return one based on `cpu_core_count` and `memory_size`."
  type        = list(string)
  default     = ["ecs.n4.xlarge"]
}

variable "worker_disk_category" {
  description = "The system disk category used to launch one or more worker nodes."
  type        = string
  default     = "cloud_efficiency"
}

variable "worker_disk_size" {
  description = "The system disk size used to launch one or more worker nodes."
  type        = number
  default     = 40
}

variable "worker_number" {
  description = "The number of kubernetes cluster work nodes."
  type        = number
}

variable "cluster_addons" {
  description = "Addon components in kubernetes cluster"
  type = list(object({
    name   = string
    config = string
  }))
  default = []
}


# Data sources

variable "vpc_name" {
  description = "Name of the VPC where to create nat gateway."
  type        = string
}

variable "vswitch_name" {
  description = "The vswitch name prefix used."
  type        = string
}
