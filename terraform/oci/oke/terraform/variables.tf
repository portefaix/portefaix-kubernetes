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

#######################################################################
# Provider

# variable "endpoint" {
#   description = "The Tenancy endpoint"
#   type        = string
# }

variable "tenancy_ocid" {
  description = "tenancy id where to create the sources"
  type        = string
}

variable "user_ocid" {
  description = "id of user that terraform will use to create the resources"
  type        = string
}

variable "fingerprint" {
  description = "fingerprint of oci api private key"
  type        = string
}

variable "private_key" {
  description = "OCI api private key used"
  type        = string
}

variable "region" {
  description = "the oci region where resources will be created"
  type        = string
}

#######################################################################
# OKE

variable "label_prefix" {
  default     = "none"
  description = "A string that will be prepended to all resources."
  type        = string
}

variable "compartment_ocid" {
  description = "compartment id where to create all resources"
  type        = string
}

# Networking

variable "vcn_display_name" {
  default     = ""
  description = "Name of the existing Virtual Cloud Network"
  type        = string
}

variable "ig_route_table_display_name" {
  default     = ""
  description = "Name of the existing NAT Gateway route table"
  type        = string
}

variable "nat_route_table_display_name" {
  default     = ""
  description = "Name of the existing Internet Gateway route table"
  type        = string
}

# Cluster

variable "cluster_name" {
  description = "The name of oke cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "The version of kubernetes to use when provisioning OKE or to upgrade an existing OKE cluster to."
  type        = string
}

variable "pods_cidr" {
  description = "The CIDR range used for IP addresses by the pods. A /16 CIDR is generally sufficient. This CIDR should not overlap with any subnet range in the VCN (it can also be outside the VCN CIDR range)."
  type        = string
}

variable "services_cidr" {
  description = "The CIDR range used by exposed Kubernetes services (ClusterIPs). This CIDR should not overlap with the VCN CIDR range."
  type        = string
}

# Node Pools

variable "node_pools" {
  default = {
    np1 = { shape = "VM.Standard.E4.Flex", ocpus = 1, memory = 16, node_pool_size = 1, boot_volume_size = 150, label = { app = "frontend", pool = "np1" } }
    np2 = { shape = "VM.Standard.E2.2", node_pool_size = 2, boot_volume_size = 150 }
    np3 = { shape = "VM.Standard.E2.2", node_pool_size = 1 }
  }
  description = "Tuple of node pools. Each key maps to a node pool. Each value is a tuple of shape (string),ocpus(number) , node_pool_size(number) and boot_volume_size(number)"
  type        = any
}

variable "node_pool_name_prefix" {
  description = "The prefix of the node pool name."
  type        = string
}

variable "node_pool_os" {
  default     = "Oracle Linux"
  description = "The name of image to use."
  type        = string
}

variable "node_pool_os_version" {
  default     = "7.9"
  description = "The version of operating system to use for the worker nodes."
  type        = string
}

# Misc

variable "freeform_tags" {
  default = {
    # vcn, bastion, and operator tags are required
    # add more tags in each as desired
    vcn      = {}
    bastion  = {}
    operator = {}
    oke = {
      service_lb = {
        made-by = "terraform"
      }
    }
  }
  description = "Tags to apply to different resources."
  type = object({
    vcn      = map(any),
    bastion  = map(any),
    operator = map(any),
    oke      = map(map(any))
  })
}
