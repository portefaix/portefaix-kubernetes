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

###########################################################################
# Kubernetes cluster

region = "cdg"

cluster_name = "portefaix-dev-vke"

kubernetes_version = "v1.22.8+3"

# network_name = "portefaix-dev"

node_quantity = 1
node_plan     = "vc2-1c-2gb"
node_label    = "portefaix-dev-vke"

node_pools = [
  # {
  #   label          = "core"
  #   quantity = 1
  #   plan = "vc2-1c-2gb"
  #   region = "cdg"
  #   tag =  "core"
  # },
  # {
  #   label          = "addons"
  #   quantity = 1
  #   plan = "vc2-1c-2gb"
  #   region = "cdg"
  #   tag =  "core"
  # }
]
