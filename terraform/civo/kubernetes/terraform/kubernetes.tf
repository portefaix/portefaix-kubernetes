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

module "kubernetes" {
  source  = "nlamirault/kubernetes/civo"
  version = "0.1.0"

  cluster_name        = var.cluster_name
  region              = var.region
  node_count          = var.node_count
  node_instance_size  = var.node_instance_size
  cni                 = var.cni
  k3s_version         = var.k3s_version
  authorized_networks = var.authorized_networks
  network_name        = var.network_name

  node_pools = var.node_pools

  tags = var.tags
}
