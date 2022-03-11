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
# Observability

# Prometheus

variable "prometheus_resource_group_name" {
  type        = string
  description = "The Name which should be used for this Resource Group"
}

variable "prometheus_resource_group_location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist"
}

# variable "prometheus_storage_account_name" {
#   type        = string
#   description = "Specifies the name of the storage account"
# }

# variable "prometheus_storage_container_name" {
#   type        = string
#   description = "The name of the Container which should be created within the Storage Account"
# }

variable "prometheus_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "made-by" = "terraform"
  }
}

# Thanos

variable "thanos_resource_group_name" {
  type        = string
  description = "The Name which should be used for this Resource Group"
}

variable "thanos_resource_group_location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist"
}

# variable "thanos_storage_account_name" {
#   type        = string
#   description = "Specifies the name of the storage account"
# }

# variable "thanos_storage_container_name" {
#   type        = string
#   description = "The name of the Container which should be created within the Storage Account"
# }

variable "thanos_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "made-by" = "terraform"
  }
}

# Loki

variable "loki_resource_group_name" {
  type        = string
  description = "The Name which should be used for this Resource Group"
}

variable "loki_resource_group_location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist"
}

# variable "loki_storage_account_name" {
#   type        = string
#   description = "Specifies the name of the storage account"
# }

# variable "loki_storage_container_name" {
#   type        = string
#   description = "The name of the Container which should be created within the Storage Account"
# }

variable "loki_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "made-by" = "terraform"
  }
}

# Tempo

variable "tempo_resource_group_name" {
  type        = string
  description = "The Name which should be used for this Resource Group"
}

variable "tempo_resource_group_location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist"
}

# variable "tempo_storage_account_name" {
#   type        = string
#   description = "Specifies the name of the storage account"
# }

# variable "tempo_storage_container_name" {
#   type        = string
#   description = "The name of the Container which should be created within the Storage Account"
# }

variable "tempo_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "made-by" = "terraform"
  }
}
