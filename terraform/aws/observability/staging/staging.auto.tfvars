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

region = "eu-west-1"

#############################################################################
# Project

org_name = "portefaix"

core_account_id = "845676325565"

##############################################################################
# Observability

cluster_name = "portefaix-staging-eks"

# Prometheus

prometheus_namespace       = "monitoring"
prometheus_service_account = "prometheus"

prometheus_enable_kms = false

prometheus_tags = {
  "Env"     = "Staging"
  "Service" = "Observability"
  "Role"    = "Prometheus"
}

# Thanos

thanos_namespace        = "monitoring"
thanos_service_accounts = ["thanos-store", "thanos-query", "thanos-compact"]

thanos_enable_kms = false

thanos_tags = {
  "Env"     = "Staging"
  "Service" = "Observability"
  "Role"    = "Thanos"
}

# Loki

loki_namespace       = "logging"
loki_service_account = "loki"

loki_enable_kms = false

loki_tags = {
  "Env"     = "Staging"
  "Service" = "Observability"
  "Role"    = "Loki"
}

# Tempo

tempo_namespace       = "tracing"
tempo_service_account = "tempo"

tempo_enable_kms = false

tempo_tags = {
  "Env"     = "Staging"
  "Service" = "Observability"
  "Role"    = "Tempo"
}

# Grafana

grafana_namespace       = "monitoring"
grafana_service_account = "grafana"

grafana_tags = {
  "Env"     = "Staging"
  "Service" = "Observability"
  "Role"    = "Grafana"
}

# AWS Managed Prometheus

amp_alias = "portefaix-staging"

amp_tags = {
  "Env"     = "Staging"
  "Service" = "Observability"
  "Role"    = "AMP"
}
