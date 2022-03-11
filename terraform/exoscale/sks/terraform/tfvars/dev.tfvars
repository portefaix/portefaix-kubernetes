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

region = "ch-dk-2"

###########################################################################
# Kubernetes cluster

name = "portefaix-dev-cluster-sks"

zone = "ch-dk-2"

kubernetes_version = "1.20.9"

service_level = "starter"

cni            = "calico"
exoscale_ccm   = true
metrics_server = true
auto_upgrade   = true

node_pools = [
  {
    name          = "core"
    instance_type = "standard.medium"
    size          = 2
  }
]
