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

#############################################################################
# Provider

# region = "eu-central-1"

#############################################################################
# ACK

cluster_name = "portefaix-staging-ack"

kubernetes_version = "1.20.11-aliyun.1"

# enable_ssh           = true
# node_cidr_mask       = 24
# slb_internet_enabled = false

worker_instance_types = ["ecs.n4.xlarge"]
worker_disk_category  = "cloud_efficiency"
worker_disk_size      = 40
worker_number         = 2

service_cidr = "192.168.0.0/16"
pod_cidr     = "172.20.32.0/20"

key_name = "portefaix-staging"

cluster_addons = [
  {
    "name"   = "csi-plugin",
    "config" = "",
  },
  {
    "name"   = "csi-provisioner",
    "config" = "",
  },
  {
    "name"   = "terway-eniip",
    "config" = "",
  },
]

tags = {
  Name    = "portefaix-staging-ack"
  Env     = "staging"
  Service = "kubernetes"
}

node_pools = {
  "core" = {
    node_count           = 3
    node_min_number      = 3
    node_max_number      = 5
    node_bind_eip        = false
    node_instance_types  = ["ecs.n4.xlarge"]
    system_disk_category = "cloud_efficiency"
    system_disk_size     = 40
    auto_repair          = true
    auto_upgrade         = true
    max_unavailable      = 1
    surge                = 1
    tags = {
      NodePool = "core"
    }
    labels = {}
  }
}

vpc_name         = "portefaix-staging"
vswitch_name     = "portefaix-staging00"
pod_vswitch_name = "portefaix-staging-pod"
