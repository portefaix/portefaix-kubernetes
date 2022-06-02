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

#####################################################################""
# Provider

region = "LON1"

###########################################################################
# Kubernetes cluster

cluster_name = "portefaix-dev-civo"

network_name = "portefaix-dev"

node_count         = 1
node_instance_size = "g3.k3s.small"
k3s_version        = "1.22.2-k3s1"

cni = "cilium"

node_pools = [
  {
    label      = "addons"
    node_count = 1
    size       = "g3.k3s.small"
    region     = "LON1"
  }
]

tags = "terraform dev kubernetes"
