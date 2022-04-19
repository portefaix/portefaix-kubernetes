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

module "prometheus" {
  source  = "nlamirault/observability/azurerm//modules/prometheus"
  version = "0.5.0"

  resource_group_name     = var.prometheus_resource_group_name
  resource_group_location = var.prometheus_resource_group_location

  tags = var.prometheus_tags
}

module "thanos" {
  source  = "nlamirault/observability/azurerm//modules/thanos"
  version = "0.5.0"

  resource_group_name     = var.thanos_resource_group_name
  resource_group_location = var.thanos_resource_group_location

  tags = var.thanos_tags
}

module "loki" {
  source  = "nlamirault/observability/azurerm//modules/loki"
  version = "0.5.0"

  resource_group_name     = var.loki_resource_group_name
  resource_group_location = var.loki_resource_group_location

  tags = var.loki_tags
}

module "tempo" {
  source  = "nlamirault/observability/azurerm//modules/tempo/"
  version = "0.5.0"

  resource_group_name     = var.tempo_resource_group_name
  resource_group_location = var.tempo_resource_group_location

  tags = var.tempo_tags
}
