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

############################################################################
# Provider

############################################################################
# Nat Gateway

variable "hub_rg_name" {
  type        = string
  description = "The name of the resource grupe of the Hub virtual network"
}


variable "hub_vnet_name" {
  type        = string
  description = "The name of the Hub virtual network"
}

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}

variable "resource_group_location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist."
}

variable "nat_gateway_name" {
  type        = string
  description = "Name of the Nat Gateway"
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)
}
