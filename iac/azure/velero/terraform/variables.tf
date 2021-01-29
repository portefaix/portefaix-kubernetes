# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

#variable resource_group_name {
#  description = "Name of the resource group to be imported."
#  type        = string
#}

#variable subscription_id {
#  type        = string
#  description = "The Subscription ID which should be used"
#}

#############################################################################
# Velero

variable "aks_resource_group_name" {
  type        = string
  description = "The Name which should be used for the AKS Resource Group"
}

#variable "velero_resource_group_name" {
#  type        = string
#  description = "The Name which should be used for this Resource Group"
#}

variable "velero_resource_group_location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist"
}

variable "storage_account_name" {
  type        = string
  description = "Specifies the name of the storage account"
}

variable "storage_container_name" {
  type        = string
  description = "The name of the Container which should be created within the Storage Account"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "made-by" = "terraform"
  }
}
