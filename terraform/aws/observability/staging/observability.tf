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

module "observability" {
  source = "../modules/observability"

  cluster_name = var.cluster_name

  prometheus_namespace       = var.prometheus_namespace
  prometheus_service_account = var.prometheus_service_account
  prometheus_tags            = var.prometheus_tags
  prometheus_enable_kms      = var.prometheus_enable_kms

  thanos_namespace        = var.thanos_namespace
  thanos_service_accounts = var.thanos_service_accounts
  thanos_tags             = var.thanos_tags
  thanos_enable_kms       = var.thanos_enable_kms

  loki_namespace       = var.loki_namespace
  loki_service_account = var.loki_service_account
  loki_tags            = var.loki_tags
  loki_enable_kms      = var.loki_enable_kms

  tempo_namespace       = var.tempo_namespace
  tempo_service_account = var.tempo_service_account
  tempo_tags            = var.tempo_tags
  tempo_enable_kms      = var.tempo_enable_kms

  grafana_namespace       = var.grafana_namespace
  grafana_service_account = var.grafana_service_account
  grafana_tags            = var.grafana_tags

  amp_alias = var.amp_alias
  amp_tags  = var.amp_tags
}
