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

#tfsec:ignore:google-gke-use-cluster-labels
#tfsec:ignore:google-gke-enable-private-cluster
#tfsec:ignore:google-gke-enable-network-policy
#tfsec:ignore:google-gke-enable-master-networks
#tfsec:ignore:google-gke-metadata-endpoints-disabled
#tfsec:ignore:google-gke-enforce-pod-security-policy
module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version = "23.3.0"

  project_id      = var.project
  name            = var.name
  release_channel = var.release_channel

  regional = var.regional
  # region   = var.location
  zones = var.zones

  cluster_resource_labels = var.cluster_resource_labels

  network    = data.google_compute_network.network.name
  subnetwork = data.google_compute_subnetwork.subnet.name

  horizontal_pod_autoscaling = var.horizontal_pod_autoscaling

  default_max_pods_per_node = var.default_max_pods_per_node

  # Automation

  enable_vertical_pod_autoscaling = var.enable_vertical_pod_autoscaling

  cluster_autoscaling = var.cluster_autoscaling

  maintenance_start_time = var.maintenance_start_time
  maintenance_end_time   = var.maintenance_end_time
  maintenance_recurrence = var.maintenance_recurrence
  maintenance_exclusions = var.maintenance_exclusions

  notification_config_topic = data.google_pubsub_topic.gke.id

  # Node pools

  create_service_account = var.create_service_account

  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count
  node_pools               = var.node_pools
  node_pools_oauth_scopes  = var.node_pools_oauth_scopes
  node_pools_labels        = var.node_pools_labels
  node_pools_metadata      = var.node_pools_metadata
  node_pools_taints        = var.node_pools_taints
  node_pools_tags          = var.node_pools_tags

  # Networking

  master_ipv4_cidr_block      = var.master_ipv4_cidr_block
  ip_range_pods               = var.ip_range_pods
  ip_range_services           = var.ip_range_services
  enable_intranode_visibility = var.enable_intranode_visibility
  master_authorized_networks  = local.master_authorized_networks
  enable_private_nodes        = var.enable_private_nodes
  dns_cache                   = var.dns_cache
  http_load_balancing         = var.http_load_balancing
  network_policy              = var.network_policy
  network_policy_provider     = var.network_policy_provider
  datapath_provider           = var.datapath_provider

  # Security

  enable_shielded_nodes             = var.enable_shielded_nodes
  enable_binary_authorization       = var.enable_binary_authorization
  identity_namespace                = var.identity_namespace
  disable_legacy_metadata_endpoints = var.disable_legacy_metadata_endpoints
  enable_confidential_nodes         = var.enable_confidential_nodes

  # Features

  cloudrun                             = var.cloudrun
  logging_service                      = var.logging_service
  monitoring_service                   = var.monitoring_service
  enable_tpu                           = var.enable_tpu
  enable_kubernetes_alpha              = var.enable_kubernetes_alpha
  istio                                = var.istio
  gce_pd_csi_driver                    = var.gce_pd_csi_driver
  config_connector                     = var.config_connector
  filestore_csi_driver                 = var.filestore_csi_driver
  monitoring_enable_managed_prometheus = var.monitoring_enable_managed_prometheus
}
