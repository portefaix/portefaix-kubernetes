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

module "aks" {
  source = "../modules/aks"

  virtual_network_name     = var.virtual_network_name
  vnet_resource_group_name = var.vnet_resource_group_name
  aks_subnet_name          = var.aks_subnet_name
  appgw_subnet_name        = var.appgw_subnet_name

  aks_resource_group_name     = var.aks_resource_group_name
  aks_resource_group_location = var.aks_resource_group_location

  cluster_name       = var.cluster_name
  prefix             = var.prefix
  kubernetes_version = var.kubernetes_version

  tags = var.tags

  private_cluster_enabled = var.private_cluster_enabled

  network_plugin = var.network_plugin
  network_policy = var.network_policy

  # net_profile_pod_cidr           = var.net_profile_pod_cidr
  net_profile_service_cidr       = var.net_profile_service_cidr
  net_profile_dns_service_ip     = var.net_profile_dns_service_ip
  net_profile_docker_bridge_cidr = var.net_profile_docker_bridge_cidr

  public_ssh_key = var.public_ssh_key

  # enable_role_based_access_control = false
  # rbac_aad_managed                 = false
  # rbac_aad_admin_group_object_ids  = var.admin_group_object_ids

  # enable_log_analytics_workspace     = false
  enable_auto_scaling                = var.enable_auto_scaling
  azure_policy_enabled                = var.azure_policy_enabled
  http_application_routing_enabled    = var.http_application_routing_enabled
  ingress_application_gateway_enabled = var.ingress_application_gateway_enabled
  open_service_mesh_enabled = var.open_service_mesh_enabled

  os_disk_size_gb           = var.os_disk_size_gb
  agents_min_count          = var.agents_min_count
  agents_max_count          = var.agents_max_count
  agents_count              = var.agents_count
  agents_max_pods           = var.agents_max_pods
  agents_pool_name          = var.agents_pool_name
  agents_availability_zones = var.agents_availability_zones
  agents_type               = var.agents_type
  agents_size               = var.agents_size
  agents_labels             = var.agents_labels
  agents_tags               = var.agents_tags

  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges

  # TODO: AKS: Another node pools
  # labels: kind/feature, priority/high, lifecycle/frozen, area/terraform, cloud/azure
  # https://github.com/Azure/terraform-azurerm-aks/pull/127
  node_pools = var.node_pools
}
