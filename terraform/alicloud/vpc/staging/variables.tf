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

#############################################################################
# Provider

variable "region" {
  type        = string
  description = "Alicloud Region"
}

#############################################################################
# VPC

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "vpc_subnet_cidr" {
  type        = string
  description = "The VPC Subnet CIDR"
}

variable "vpc_tags" {
  type        = map(string)
  description = "Tags for VPC"
  default = {
    "made-by" = "terraform"
  }
}

variable "vswitch_name" {
  description = "The vswitch name prefix used to launch several new vswitches."
  type        = string
}

variable "vswitch_cidrs" {
  description = "List of cidr blocks used to launch several new vswitches. If not set, there is no new vswitches will be created."
  type        = list(string)
}

variable "vswitch_tags" {
  type        = map(string)
  description = "Tags used to launch serveral vswitches"
  default = {
    "made-by" = "terraform"
  }
}

variable "pod_vswitch_name" {
  description = "The vswitch name prefix used to launch several new Pod vswitches."
  type        = string
}

variable "pod_vswitch_cidrs" {
  description = "List of pod subnets in CIDR format"
  type        = list(string)
}

variable "pod_vswitch_tags" {
  type        = map(string)
  description = "Tags used to launch serveral Pod vswitches"
  default = {
    "made-by" = "terraform"
  }
}

variable "availability_zones" {
  description = "List available zones to launch several VSwitches."
  type        = list(string)
}

# variable "destination_cidrs" {
#   description = "List of destination CIDR block of virtual router in the specified VPC."
#   type        = list(string)
#   default     = []
# }

# variable "nexthop_ids" {
#   description = "List of next hop instance IDs of virtual router in the specified VPC."
#   type        = list(string)
#   default     = []
# }
