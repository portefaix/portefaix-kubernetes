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

#############################################################################
# Provider

region = "eu-west-3"

##############################################################################
# Observability

cluster_name = "portefaix-staging-eks"

# Prometheus

prometheus_namespace       = "monitoring"
prometheus_service_account = "prometheus"

prometheus_tags = {
    "project" = "portefaix"
    "env"     = "staging"
    "service" = "prometheus"
    "made-by" = "terraform"
}

# Thanos

thanos_namespace        = "monitoring"
thanos_service_accounts = ["thanos"] #["thanos-store", "thanos-query", "thanos-compact"]

thanos_tags = {
    "project" = "portefaix"
    "env"     = "staging"
    "service" = "thanos"
    "made-by" = "terraform"
}

# Loki

loki_namespace       = "logging"
loki_service_account = "loki"

loki_tags = {
    "project" = "portefaix"
    "env"     = "staging"
    "service" = "loki"
    "made-by" = "terraform"
}

# Tempo

tempo_namespace       = "tracing"
tempo_service_account = "tempo"

tempo_tags = {
    "project" = "portefaix"
    "env"     = "staging"
    "service" = "tempo"
    "made-by" = "terraform"
}