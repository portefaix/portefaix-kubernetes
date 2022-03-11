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

module "ack" {
  source = "../modules/ack"

  cluster_name       = var.cluster_name
  pod_cidr           = var.pod_cidr
  service_cidr       = var.service_cidr
  kubernetes_version = var.kubernetes_version

  enable_ssh = var.enable_ssh
  key_name   = var.key_name

  cpu_core_count        = var.cpu_core_count
  memory_size           = var.memory_size
  worker_number         = var.worker_number
  worker_instance_types = var.worker_instance_types
  worker_disk_category  = var.worker_disk_category
  worker_disk_size      = var.worker_disk_size

  cluster_addons = var.cluster_addons

  node_pools = var.node_pools

  tags = var.tags

  vpc_name         = var.vpc_name
  vswitch_name     = var.vswitch_name
  pod_vswitch_name = var.pod_vswitch_name
}
