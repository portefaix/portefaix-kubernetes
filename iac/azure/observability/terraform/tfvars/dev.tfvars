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

############################################################################
# Provider

resource_group_name = "portefaix-dev"

##############################################################################
# Obervability

aks_resource_group_name = "portefaix-dev"
cluster_name            = "portefaix-dev-aks"

# Prometheus

prometheus_resource_group_name     = "portefaix-dev-prometheus"
prometheus_resource_group_location = "West Europe"

prometheus_storage_account_name   = "portefaixdevprometheus"
prometheus_storage_container_name = "portefaix-dev-prometheus"

prometheus_tags = {
    "made-by" = "terraform"
    "service" = "prometheus"
    "project" = "portefaix"
    "env"     = "dev"
}

# Thanos

thanos_resource_group_name     = "portefaix-dev-thanos"
thanos_resource_group_location = "West Europe"

thanos_storage_account_name   = "portefaixdevthanos"
thanos_storage_container_name = "portefaix-dev-thanos"

thanos_tags = {
    "made-by" = "terraform"
    "service" = "thanos"
    "project" = "portefaix"
    "env"     = "dev"
}

# Loki

loki_resource_group_name     = "portefaix-dev-loki"
loki_resource_group_location = "West Europe"

loki_storage_account_name   = "portefaixdevloki"
loki_storage_container_name = "portefaix-dev-loki"

loki_tags = {
    "made-by" = "terraform"
    "service" = "loki"
    "project" = "portefaix"
    "env"     = "dev"
}

# Tempo

tempo_resource_group_name     = "portefaix-dev-tempo"
tempo_resource_group_location = "West Europe"

tempo_storage_account_name   = "portefaixdevtempo"
tempo_storage_container_name = "portefaix-dev-tempo"

tempo_tags = {
    "made-by" = "terraform"
    "service" = "tempo"
    "project" = "portefaix"
    "env"     = "dev"
}