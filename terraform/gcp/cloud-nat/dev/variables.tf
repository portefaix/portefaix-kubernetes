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

variable "project" {
  type        = string
  description = "The project in which the resource belongs"
}

variable "region" {
  type        = string
  description = "The location linked to the project"
}

#############################################################################
# Cloud NAT

variable "nat_name" {
  type        = string
  description = "Name of the Cloud NAT"
}

variable "nat_router_name" {
  type        = string
  description = "The name of the router in which this NAT will be configured"
}

variable "nat_network" {
  type        = string
  description = "Name of the network"
}

variable "nat_external_ip_0_name" {
  type        = string
  description = "Name of the first External IP to use"
}

variable "nat_external_ip_1_name" {
  type        = string
  description = "Name of the second External IP to use"
}

variable "min_ports_per_vm" {
  type        = number
  description = "Minimum number of ports allocated to a VM from this NAT config"
}
