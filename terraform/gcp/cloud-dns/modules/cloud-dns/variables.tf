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

######################################################################
# Provider

variable "project" {
  type        = string
  description = "The project in which the resource belongs"
}

variable "region" {
  type        = string
  description = "The location linked to the project"
}

############################################################################
# Cloud DNS

variable "network_name" {
  type        = string
  description = "Name of the network to use"
}

variable "zone_name" {
  type        = string
  description = "Zone name"
}

variable "domain_name" {
  type        = string
  description = "Zone domain, must end with a period."
}

variable "labels" {
  description = "Map of labels to apply to the DNS"
  type        = map(string)
  default = {
    "made-by" = "terraform"
  }
}
