# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

module "prometheus" {
  source  = "nlamirault/observability/azurerm//modules/prometheus"
  version = "0.4.0"
  
  aks_resource_group_name = var.aks_resource_group_name
  cluster_name            = var.cluster_name

  prometheus_resource_group_name     = var.prometheus_resource_group_name
  prometheus_resource_group_location = var.prometheus_resource_group_location

  storage_account_name   = var.prometheus_storage_account_name
  storage_container_name = var.prometheus_storage_container_name

  tags = var.prometheus_tags
}

module "thanos" {
  source  = "nlamirault/observability/azurerm//modules/thanos"
  version = "0.4.0"
  
  aks_resource_group_name = var.aks_resource_group_name
  cluster_name            = var.cluster_name

  thanos_resource_group_name     = var.thanos_resource_group_name
  thanos_resource_group_location = var.thanos_resource_group_location

  storage_account_name   = var.thanos_storage_account_name
  storage_container_name = var.thanos_storage_container_name

  tags = var.thanos_tags
}

module "loki" {
  source  = "nlamirault/observability/azurerm//modules/loki"
  version = "0.4.0"
  
  aks_resource_group_name = var.aks_resource_group_name
  cluster_name            = var.cluster_name

  loki_resource_group_name     = var.loki_resource_group_name
  loki_resource_group_location = var.loki_resource_group_location

  storage_account_name   = var.loki_storage_account_name
  storage_container_name = var.loki_storage_container_name

  tags = var.loki_tags
}

module "tempo" {
  source  = "nlamirault/observability/azurerm//modules/tempo/"
  version = "0.4.0"
  
  aks_resource_group_name = var.aks_resource_group_name
  cluster_name            = var.cluster_name

  tempo_resource_group_name     = var.tempo_resource_group_name
  tempo_resource_group_location = var.tempo_resource_group_location

  storage_account_name   = var.tempo_storage_account_name
  storage_container_name = var.tempo_storage_container_name

  tags = var.tempo_tags
}
