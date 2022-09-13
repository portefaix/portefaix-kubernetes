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

module "k8s" {
  source  = "nlamirault/doks/digitalocean"
  version = "0.4.0"

  cluster_name       = var.cluster_name
  auto_upgrade       = var.auto_upgrade
  region             = var.region
  kubernetes_version = var.kubernetes_version

  vpc_uuid = data.digitalocean_vpc.this.id

  maintenance_policy_day        = var.maintenance_policy_day
  maintenance_policy_start_time = var.maintenance_policy_start_time

  size        = var.size
  auto_scale  = var.auto_scale
  min_nodes   = var.min_nodes
  max_nodes   = var.max_nodes
  node_count  = var.node_count
  node_tags   = var.node_tags
  node_labels = var.node_labels

  node_pools = var.node_pools

  tags = var.tags
}
