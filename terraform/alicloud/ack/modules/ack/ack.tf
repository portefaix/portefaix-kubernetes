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

#tfsec:ignore:GEN001
#tfsec:ignore:GEN003
module "ack" {
  # source  = "terraform-alicloud-modules/managed-kubernetes/alicloud"
  # version = "1.5.0"
  source = "git::https://github.com/nlamirault/terraform-alicloud-managed-kubernetes.git?ref=feat/new-features"

  k8s_name_prefix    = var.cluster_name
  k8s_pod_cidr       = var.pod_cidr
  k8s_service_cidr   = var.service_cidr
  kubernetes_version = var.kubernetes_version
  runtime            = var.runtime

  enable_ssh = var.enable_ssh
  key_name   = var.key_name

  new_vpc            = false
  vswitch_ids        = data.alicloud_vswitches.this.vswitches[*].id
  terway_vswitch_ids = data.alicloud_vswitches.pods.vswitches[*].id
  new_nat_gateway    = false

  cpu_core_count        = var.cpu_core_count
  memory_size           = var.memory_size
  worker_number         = var.worker_number
  worker_instance_types = var.worker_instance_types
  worker_disk_category  = var.worker_disk_category
  worker_disk_size      = var.worker_disk_size

  cluster_addons = var.cluster_addons

  node_pools = var.node_pools

  tags = var.tags
}
