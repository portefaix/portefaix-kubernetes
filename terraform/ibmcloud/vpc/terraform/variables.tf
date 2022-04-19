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
# VPC

variable "vpc_name" {
  description = "Name of the vpc"
  type        = string
}

variable "resource_group_name" {
  description = "Name of resource group."
  type        = string
}

variable "classic_access" {
  description = "Classic Access to the VPC"
  type        = bool
}

variable "default_address_prefix" {
  description = "Default address prefix creation method"
  type        = string
}

variable "default_network_acl_name" {
  description = "Name of the Default ACL"
  type        = string
}

variable "default_security_group_name" {
  description = "Name of the Default Security Group"
  type        = string
}

variable "default_routing_table_name" {
  description = "Name of the Default Routing Table"
  type        = string
}

variable "vpc_tags" {
  description = "List of Tags for the vpc"
  type        = list(string)
  default     = ["terraform"]
}

variable "address_prefixes" {
  description = "List of Prefixes for the vpc"
  type = list(object({
    name     = string
    location = string
    ip_range = string
  }))
  default = []
}

variable "locations" {
  description = "zones per region"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "number_of_addresses" {
  description = "Number of IPV4 Addresses"
  type        = number
}

variable "create_gateway" {
  description = "True to create new Gateway"
  type        = bool
}

variable "public_gateway_name" {
  description = "Name of the Public Gateway"
  type        = string
}

# variable "floating_ip" {
#   description = "Floating IP `id`'s or `address`'es that you want to assign to the public gateway"
#   type        = map
# }

variable "gateway_tags" {
  description = "List of Tags for the gateway"
  type        = list(string)
  default     = ["terraform", "gateway"]
}
