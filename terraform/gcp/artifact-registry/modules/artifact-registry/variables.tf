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
# Artifact Registry

variable "labels" {
  type        = map(string)
  description = "Map of maps containing node labels by node-pool name"
  default = {
    "made-by" : "terraform"
  }
}

variable "repositories" {
  description = "The name of the router in which this NAT will be configured"
  type = map(object({
    location = string
    format   = string
  }))
}

variable "readers" {
  type        = set(string)
  description = "Readonly service accounts, users, ..."
}

variable "writers" {
  type        = set(string)
  description = "ReadWrite service accounts, users, ..."
}
