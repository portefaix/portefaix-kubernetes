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


#############################################################################
# Hub

variable "hub_rg_name" {
  type        = string
  description = "The name of the resource grupe of the Hub virtual network"
}

variable "appgw_westeurope_ip_name" {
  type        = string
  description = "Name of the IP Address for the Application Gateway"
}

#############################################################################
# Traffic Manager

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group for Traffic Manager"
}

variable "resource_group_location" {
  type        = string
  description = "The Azure Region where the Resource Group for Traffic Manager should exist."
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "profile_name" {
  type        = string
  description = "Traffic Manager profile name"
}

variable "dns_ttl" {
  type        = number
  description = "The TTL value of the Profile used by Local DNS resolvers and clients"
  default     = 60
}

variable "monitor_protocol" {
  type        = string
  description = "The protocol used by the monitoring checks, supported values are HTTP, HTTPS and TCP."
  default     = "tcp"
}

variable "monitor_port" {
  type        = number
  description = "The port number used by the monitoring checks"
  default     = 80
}

variable "monitor_path" {
  type        = string
  description = "The path used by the monitoring checks"
  default     = ""
}

variable "monitor_probe_interval" {
  type        = number
  description = "The interval used to check the endpoint health from a Traffic Manager probing agent"
  default     = 10
}

variable "monitor_probe_timeout" {
  type        = number
  description = "The amount of time the Traffic Manager probing agent should wait before considering that check a failure"
  default     = 5
}

variable "monitor_tolerated_failures" {
  type        = number
  description = "The number of failures a Traffic Manager probing agent tolerates before marking that endpoint as unhealthy"
  default     = 3
}
