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

##############################################################################
# Observability

cluster_name = "portefaix-staging-eks"

# Prometheus

prometheus_namespace       = "monitoring"
prometheus_service_account = "prometheus"

prometheus_enable_kms = false

prometheus_tags = {
  "Env"               = "staging"
  "Service"           = "prometheus"
  "Portefaix-Version" = "v0.31.0"
}

# Thanos

thanos_namespace        = "monitoring"
thanos_service_accounts = ["thanos-store", "thanos-query", "thanos-compact"]

thanos_enable_kms = false

thanos_tags = {
  "Env"               = "staging"
  "Service"           = "thanos"
  "Portefaix-Version" = "v0.31.0"
}

# Loki

loki_namespace       = "logging"
loki_service_account = "loki"

loki_enable_kms = false

loki_tags = {
  "Env"               = "staging"
  "Service"           = "loki"
  "Portefaix-Version" = "v0.31.0"
}

# Tempo

tempo_namespace       = "tracing"
tempo_service_account = "tempo"

tempo_enable_kms = false

tempo_tags = {
  "Env"               = "staging"
  "Service"           = "tempo"
  "Portefaix-Version" = "v0.31.0"
}

# Grafana

grafana_namespace       = "monitoring"
grafana_service_account = "grafana"

grafana_tags = {
  "Env"               = "staging"
  "Service"           = "grafana"
  "Portefaix-Version" = "v0.31.0"
}

# AWS Managed Prometheus

amp_alias = "portefaix-staging"
