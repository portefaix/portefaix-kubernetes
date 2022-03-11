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

region = "eu-gb"


##############################################################################
# IKS

resource_group_name = "portefaix-staging"

vpc_name = "portefaix-staging"

cluster_name = "portefaix-staging-iks"

kube_version = "1.22.6"

service_subnet = "192.168.0.0/20"
pod_subnet     = "192.168.16.0/20"

worker_pool_flavor = "cx2.2x4"

worker_nodes_per_zone = 1
worker_labels = {
  Name    = "portefaix-staging-iks-core"
  Env     = "staging"
  Service = "kubernetes"
  Role    = "core"
}

tags = ["terraform", "iks", "kubernetes"]

taints = []

node_pools = [
  {
    name           = "ops"
    nodes_per_zone = 1
    flavor         = "cx2.2x4"
    labels = {
      Name    = "portefaix-staging-iks-core"
      Env     = "staging"
      Service = "kubernetes"
      Role    = "ops"
    }
    taints = [
      {
        key    = "role"
        value  = "ops"
        effect = "NoSchedule"
      },
    ]
  }
]
