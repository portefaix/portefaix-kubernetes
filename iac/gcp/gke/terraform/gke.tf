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
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version = "17.0.0"

  project_id      = var.project
  name            = var.name
  release_channel = var.release_channel

  region                  = var.location
  zones                   = var.zones
  cluster_resource_labels = var.cluster_resource_labels
  
  network    = data.google_compute_network.network.name
  subnetwork = data.google_compute_subnetwork.subnet.name

  master_authorized_networks = var.master_authorized_networks

  ip_range_pods     = var.ip_range_pods
  ip_range_services = var.ip_range_services

  enable_vertical_pod_autoscaling = var.enable_vertical_pod_autoscaling
  horizontal_pod_autoscaling      = var.horizontal_pod_autoscaling
  http_load_balancing             = var.http_load_balancing
  network_policy                  = var.network_policy
  network_policy_provider         = var.network_policy_provider
  datapath_provider               = var.datapath_provider
  enable_shielded_nodes           = var.enable_shielded_nodes
  enable_binary_authorization     = var.enable_binary_authorization
  monitoring_service              = var.monitoring_service
  logging_service                 = var.logging_service
  identity_namespace              = var.identity_namespace
  istio                           = var.istio
  cloudrun                        = var.cloudrun
  gce_pd_csi_driver               = var.gce_pd_csi_driver
  dns_cache                       = var.dns_cache
  config_connector                = var.config_connector
  enable_tpu                      = var.enable_tpu
  
  notification_config_topic       = var.notification_config_topic

  disable_legacy_metadata_endpoints = var.disable_legacy_metadata_endpoints
  enable_kubernetes_alpha           = var.enable_kubernetes_alpha

  enable_private_nodes = var.enable_private_nodes

  default_max_pods_per_node = var.default_max_pods_per_node

  maintenance_start_time = var.maintenance_start_time
  maintenance_end_time   = var.maintenance_end_time
  maintenance_recurrence = var.maintenance_recurrence
  maintenance_exclusions = var.maintenance_exclusions

  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count
  node_pools               = var.node_pools
  node_pools_oauth_scopes  = var.node_pools_oauth_scopes
  node_pools_labels        = var.node_pools_labels
  node_pools_metadata      = var.node_pools_metadata
  node_pools_taints        = var.node_pools_taints
  node_pools_tags          = var.node_pools_tags 
}
