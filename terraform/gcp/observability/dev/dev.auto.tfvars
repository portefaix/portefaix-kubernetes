
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

######################################################################
# Provider

project = "portefaix-dev"

region = "europe-west1"

##############################################################################
# Obervability

# Prometheus

prometheus_namespace       = "monitoring"
prometheus_service_account = "prometheus"

# Thanos

thanos_bucket_location      = "europe-west1"
thanos_bucket_storage_class = "STANDARD"
thanos_bucket_labels = {
  env               = "dev"
  service           = "thanos"
  made-by           = "terraform"
  portefaix-version = "v0-43-0"
}

thanos_namespace = "monitoring"
thanos_service_account = [
  "thanos-bucket",
  "thanos-store",
  "thanos-compact",
  "thanos-query",
  "thanos-query-fronted",
  "thanos-rule",
]
thanos_sidecar_service_account = "prometheus-sidecar"

thanos_enable_kms       = false
thanos_keyring_location = "europe-west1"

# Loki

loki_bucket_location      = "europe-west1"
loki_bucket_storage_class = "STANDARD"
loki_bucket_labels = {
  env               = "dev"
  service           = "loki"
  made-by           = "terraform"
  portefaix-version = "v0-43-0"
}

loki_namespace       = "monitoring"
loki_service_account = "loki"

loki_enable_kms       = false
loki_keyring_location = "europe-west1"

# Tempo

tempo_bucket_location      = "europe-west1"
tempo_bucket_storage_class = "STANDARD"
tempo_bucket_labels = {
  env               = "dev"
  service           = "tempo"
  made-by           = "terraform"
  portefaix-version = "v0-43-0"
}

tempo_namespace       = "monitoring"
tempo_service_account = "tempo"

tempo_enable_kms       = false
tempo_keyring_location = "europe-west1"

# Grafana

grafana_namespace       = "monitoring"
grafana_service_account = "grafana"
