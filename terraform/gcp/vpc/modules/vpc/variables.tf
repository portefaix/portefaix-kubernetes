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
# VPC

variable "project" {
  type        = string
  description = "The project in which the resource belongs"
}

variable "network_name" {
  type        = string
  description = "Name of the network"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "subnet_region" {
  type        = string
  description = "The region of the subnet"
}

variable "subnet_cidr" {
  type        = string
  description = "IP range of the subnet"
}

variable "secondary_ranges" {
  type = map(list(object({
    range_name    = string,
    ip_cidr_range = string
  })))
  description = "Secondary ranges"
}
