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
  source  = "nlamirault/observability/azure//modules/prometheus"
  version = "0.2.0"
  #source = "/home/nicolas/Projects/terraform-azure-observability/modules/prometheus"

  aks_resource_group_name = var.aks_resource_group_name

  prometheus_resource_group_name     = var.prometheus_resource_group_name
  prometheus_resource_group_location = var.prometheus_resource_group_location

  storage_account_name   = var.prometheus_storage_account_name
  storage_container_name = var.prometheus_storage_container_name

  tags = var.prometheus_tags
}

module "thanos" {
  source  = "nlamirault/observability/azure//modules/thanos"
  version = "0.2.0"
  #source = "/home/nicolas/Projects/terraform-azure-observability/modules/thanos"

  aks_resource_group_name = var.aks_resource_group_name

  thanos_resource_group_name     = var.thanos_resource_group_name
  thanos_resource_group_location = var.thanos_resource_group_location

  storage_account_name   = var.thanos_storage_account_name
  storage_container_name = var.thanos_storage_container_name

  tags = var.thanos_tags
}

module "loki" {
  source  = "nlamirault/observability/azure//modules/loki"
  version = "0.2.0"
  #source = "/home/nicolas/Projects/terraform-azure-observability/modules/loki"

  aks_resource_group_name = var.aks_resource_group_name

  loki_resource_group_name     = var.loki_resource_group_name
  loki_resource_group_location = var.loki_resource_group_location

  storage_account_name   = var.loki_storage_account_name
  storage_container_name = var.loki_storage_container_name

  tags = var.loki_tags
}

module "tempo" {
  source  = "nlamirault/observability/azure//modules/tempo/"
  version = "0.2.0"
  #source = "/home/nicolas/Projects/terraform-azure-observability/modules/tempo"

  aks_resource_group_name = var.aks_resource_group_name

  tempo_resource_group_name     = var.tempo_resource_group_name
  tempo_resource_group_location = var.tempo_resource_group_location

  storage_account_name   = var.tempo_storage_account_name
  storage_container_name = var.tempo_storage_container_name

  tags = var.tempo_tags
}

