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

module "iks" {
  source  = "terraform-ibm-modules/cluster/ibm//modules/vpc-kubernetes"
  version = "1.5.0"

  resource_group_id = data.ibm_resource_group.this.id
  vpc_id            = data.ibm_is_vpc.this.id

  cluster_name     = var.cluster_name
  kube_version     = var.kube_version
  cos_instance_crn = var.cos_instance_crn

  worker_pool_flavor    = var.worker_pool_flavor
  worker_nodes_per_zone = var.worker_nodes_per_zone
  worker_labels         = var.worker_labels
  worker_zones          = local.worker_zones

  tags = var.tags

  service_subnet = var.service_subnet
  pod_subnet     = var.pod_subnet

  taints = var.taints

  # create_timeout = var.create_timeout
  # update_timeout = var.update_timeout
  # delete_timeout = var.delete_timeout
}

module "pools" {
  source  = "terraform-ibm-modules/cluster/ibm//modules/configure-vpc-worker-pool"
  version = "1.5.0"

  for_each = { for pool in var.node_pools : pool.name => pool }

  resource_group_id     = data.ibm_resource_group.this.id
  virtual_private_cloud = data.ibm_is_vpc.this.id

  cluster_name          = module.iks.kubernetes_vpc_cluster_id
  worker_pool_name      = each.value.name
  worker_nodes_per_zone = each.value.nodes_per_zone
  flavor                = each.value.flavor
  worker_zones          = local.worker_zones
  labels                = each.value.labels
  taints                = each.value.taints

  # create_timeout        = var.create_timeout
  # delete_timeout        = var.delete_timeout
}

module "alb" {
  source  = "terraform-ibm-modules/cluster/ibm//modules/configure-vpc-alb"
  version = "1.5.0"

  alb_id            = data.ibm_container_vpc_cluster.this.albs[0].id
  enable            = var.alb_enable
  resource_group_id = data.ibm_resource_group.this.id

  depends_on = [
    module.iks
  ]
}
