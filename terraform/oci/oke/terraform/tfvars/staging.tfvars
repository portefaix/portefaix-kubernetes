# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

region = "uk-london-1"

##############################################################################
# OKE

label_prefix = "portefaix-staging"

vcn_display_name             = "portefaix-staging-core"
ig_route_table_display_name  = "portefaix-staging-nat-route"
nat_route_table_display_name = "portefaix-staging-internet-route"

cluster_name       = "oke"
kubernetes_version = "v1.21.5"
pods_cidr          = "10.244.0.0/16"
services_cidr      = "10.96.0.0/16"

node_pool_name_prefix = "np"
node_pool_os          = "Oracle Linux"
node_pool_os_version  = "7.9"
node_pools = {
  core = {
    shape            = "VM.Standard.A1.Flex",
    ocpus            = 1,
    memory           = 6,
    node_pool_size   = 0,
    boot_volume_size = 150,
    label = {
      node-pool = "core",
    }
  }
  ops = {
    shape            = "VM.Standard.A1.Flex",
    ocpus            = 1,
    memory           = 16,
    node_pool_size   = 0,
    boot_volume_size = 150
    label = {
      node-pool = "ops"
    }
  }
}

freeform_tags = {
  oke = {
    project = "portefaix-staging"
    env     = "staging"
    service = "oke"
    made-by = "terraform"
  }
}
