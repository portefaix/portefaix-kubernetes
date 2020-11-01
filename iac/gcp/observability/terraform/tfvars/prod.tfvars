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

#####################################################################""
# Provider

project = "portefaix-lab-prod"

region = "europe-west1"


##############################################################################
# Obervability

# Prometheus

prometheus_account_id   = "portefaix-lab-prometheus"
prometheus_display_name = "Observability Prometheus"

prometheus_secret_location = "europe-west1"
prometheus_secret_labels = {
  env      = "prod"
  service  = "prometheus"
  made-by  = "terraform"
}

# Thanos

thanos_account_id   = "portefaix-lab-thanos"
thanos_display_name = "Observability Thanos"

thanos_bucket_location      = "europe-west1"
thanos_bucket_storage_class = "STANDARD"
thanos_bucket_labels        = {
  env      = "prod"
  service  = "thanos"
  made-by  = "terraform"
}

thanos_secret_location = "europe-west1"
thanos_secret_labels = {
  env      = "prod"
  service  = "thanos"
  made-by  = "terraform"
}

# Loki

loki_account_id   = "portefaix-lab-loki"
loki_display_name = "Observability Loki"

loki_bucket_location      = "europe-west1"
loki_bucket_storage_class = "STANDARD"
loki_bucket_labels        = {
  env      = "prod"
  service  = "loki"
  made-by  = "terraform"
}

loki_secret_location = "europe-west1"
loki_secret_labels = {
  env      = "prod"
  service  = "loki"
  made-by  = "terraform"
}

# Tempo

tempo_account_id   = "portefaix-lab-tempo"
tempo_display_name = "Observability Tempo"

tempo_bucket_location      = "europe-west1"
tempo_bucket_storage_class = "STANDARD"
tempo_bucket_labels        = {
  env      = "prod"
  service  = "tempo"
  made-by  = "terraform"
}

tempo_secret_location = "europe-west1"
tempo_secret_labels = {
  env      = "prod"
  service  = "tempo"
  made-by  = "terraform"
}