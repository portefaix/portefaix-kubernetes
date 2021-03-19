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

module "gke" {
  source  = "nlamirault/gke/google"
  version = "0.7.0"

  project  = var.project
  location = var.location

  network        = data.google_compute_network.network.name
  subnet_network = data.google_compute_subnetwork.subnet.name

  name                       = var.name
  release_channel            = var.release_channel
  network_config             = var.network_config
  master_ipv4_cidr_block     = var.master_ipv4_cidr_block
  master_authorized_networks = var.master_authorized_networks

  rbac_group_domain = var.rbac_group_domain

  maintenance_start_time = var.maintenance_start_time

  auto_scaling_max_cpu = var.auto_scaling_max_cpu
  auto_scaling_min_cpu = var.auto_scaling_min_cpu
  auto_scaling_max_mem = var.auto_scaling_max_mem
  auto_scaling_min_mem = var.auto_scaling_min_mem

  default_max_pods_per_node = var.default_max_pods_per_node

  labels = var.labels

  network_policy             = var.network_policy
  auto_scaling               = var.auto_scaling
  hpa                        = var.hpa
  pod_security_policy        = var.pod_security_policy
  monitoring_service         = var.monitoring_service
  logging_service            = var.logging_service
  binary_authorization       = var.binary_authorization
  google_cloud_load_balancer = var.google_cloud_load_balancer
  istio                      = var.istio
  cloudrun                   = var.cloudrun
  csi_driver                 = var.csi_driver
  config_connector           = var.config_connector

  datapath_provider = var.datapath_provider

  oauth_scopes  = var.oauth_scopes
  node_metadata = var.node_metadata
  auto_upgrade  = var.auto_upgrade
  auto_repair   = var.auto_repair
  image_type    = var.image_type
  node_labels   = var.node_labels
  node_tags     = var.node_tags
  node_pools    = var.node_pools
}
