# Copyright (C) 2020-2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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
  source = "/home/nicolas/Projects/terraform-alicloud-ack"
  # source  = "nlamirault/ack/alicloud"
  # version = "0.2.0"

  vpc_name     = var.vpc_name
  vswitch_name = var.vswitch_name

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version

  enable_ssh            = var.enable_ssh
  service_cidr          = var.service_cidr
  node_cidr_mask        = var.node_cidr_mask
  pod_vswitch_name      = var.pod_vswitch_name
  slb_internet_enabled  = var.slb_internet_enabled

  worker_number         = var.worker_number
  worker_instance_types = var.worker_instance_types

  cluster_addons = var.cluster_addons

  min_size = var.min_size
  max_size = var.max_size

  tags = var.tags
}
