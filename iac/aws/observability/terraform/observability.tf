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
  source  = "nlamirault/observability/aws//modules/prometheus"
  version = "0.6.0"

  cluster_name = var.cluster_name

  namespace       = var.prometheus_namespace
  service_account = var.prometheus_service_account

  bucket_name = module.thanos.bucket

  tags = var.prometheus_tags
}

module "thanos" {
  source  = "nlamirault/observability/aws//modules/thanos"
  version = "0.6.0"

  cluster_name = var.cluster_name

  namespace        = var.thanos_namespace
  service_accounts = var.thanos_service_accounts

  tags = var.thanos_tags
}

module "loki" {
  source  = "nlamirault/observability/aws//modules/loki"
  version = "0.6.0"

  cluster_name = var.cluster_name

  namespace       = var.loki_namespace
  service_account = var.loki_service_account

  tags = var.loki_tags
}

module "tempo" {
  source  = "nlamirault/observability/aws//modules/tempo"
  version = "0.6.0"

  cluster_name = var.cluster_name

  namespace       = var.tempo_namespace
  service_account = var.tempo_service_account

  tags = var.tempo_tags
}

module "grafana" {
  source  = "nlamirault/observability/aws//modules/grafana"
  version = "0.6.0"

  cluster_name = var.cluster_name

  namespace       = var.grafana_namespace
  service_account = var.grafana_service_account

  tags = var.grafana_tags
}
