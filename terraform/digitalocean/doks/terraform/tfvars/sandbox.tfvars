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


##############################################################################
# Kubernetes

vpc_name = "portefaix-sandbox"

cluster_name = "portefaix-sandbox-do-k8s"

region = "fra1"

kubernetes_version = "1.20.8"
auto_upgrade       = true
size               = "s-1vcpu-2gb"

maintenance_policy_day        = "sunday"
maintenance_policy_start_time = "04:00"

auto_scale = true
min_nodes  = 1
max_nodes  = 2
node_count = 1

node_labels = {
  env     = "sandbox"
  service = "kubernetes"
  made-by = "terraform"
}

node_tags = ["kubernetes", "nodes"]

node_pools = {}
#node_pools = {
#  "ops" = {
#    auto_scale = true
#    min_nodes = 1
#    max_nodes = 3
#    node_count = 1
#    size = "s-1vcpu-2gb"
#    node_labels = {
#      env      = "sandbox"
#      service  = "kubernetes"
#      made-by  = "terraform"
#  }
#    node_tags = ["kubernetes", "nodes"]
#  }
#}
