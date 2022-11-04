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

############################################################################
# Provider


##############################################################################
# Obervability

# Prometheus

prometheus_resource_group_name     = "portefaix-dev"
prometheus_resource_group_location = "West Europe"

prometheus_tags = {
  "made-by"           = "terraform"
  "service"           = "prometheus"
  "project"           = "portefaix"
  "env"               = "dev"
  "portefaix-version" = "v0.43.0"
}

# Thanos

thanos_resource_group_name     = "portefaix-dev"
thanos_resource_group_location = "West Europe"

thanos_tags = {
  "made-by"           = "terraform"
  "service"           = "thanos"
  "project"           = "portefaix"
  "env"               = "dev"
  "portefaix-version" = "v0.43.0"
}

# Loki

loki_resource_group_name     = "portefaix-dev"
loki_resource_group_location = "West Europe"

loki_tags = {
  "made-by"           = "terraform"
  "service"           = "loki"
  "project"           = "portefaix"
  "env"               = "dev"
  "portefaix-version" = "v0.43.0"
}

# Tempo

tempo_resource_group_name     = "portefaix-dev"
tempo_resource_group_location = "West Europe"

tempo_tags = {
  "made-by"           = "terraform"
  "service"           = "tempo"
  "project"           = "portefaix"
  "env"               = "dev"
  "portefaix-version" = "v0.43.0"
}
