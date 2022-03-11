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

#variable "subscription_id" {
#  type        = string
#  description = "The Subscription ID which should be used"
#}


#############################################################################
# Core

# variable "resource_group_name" {
#   description = "Name of the resource group to be imported."
#   type        = string
# }

variable "sp_name" {
  description = "Name of the main service."
  type        = string
}

#############################################################################
# AKS

# variable "aks_resource_group_name" {
#   type        = string
#   description = "The Name which should be used for the AKS Resource Group"
# }

# variable "cluster_name" {
#   type        = string
#   description = "Name of the AKS cluster"
# }

#############################################################################
# Sops

variable "resource_group_name" {
  type        = string
  description = "The Name which should be used for this Resource Group"
}

variable "resource_group_location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "made-by" = "terraform"
  }
}
