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

module "aks" {
  source  = "nlamirault/aks/azurerm"
  version = "0.8.0"

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location

  cluster_name     = var.cluster_name
  cluster_location = var.cluster_location

  subnet_name              = var.subnet_name
  virtual_network_name     = var.virtual_network_name
  vnet_resource_group_name = var.vnet_resource_group_name

  # aad_group_name = var.aad_group_name

  kubernetes_version  = var.kubernetes_version
  pod_security_policy = var.pod_security_policy
  # rbac                = var.rbac

  api_server_authorized_ip_ranges = var.authorized_ip_ranges

  # Default node pool
  node_count              = var.node_count
  node_vm_size            = var.node_vm_size
  os_disk_size_gb         = var.os_disk_size_gb
  node_availability_zones = var.node_availability_zones
  enable_auto_scaling     = var.enable_auto_scaling
  node_min_count          = var.node_min_count
  node_max_count          = var.node_max_count
  node_max_pods           = var.node_max_pods
  node_taints             = var.node_taints

  # Network profile
  network_plugin     = var.network_plugin
  network_policy     = var.network_policy
  pod_cidr           = null # var.pod_cidr
  service_cidr       = var.service_cidr
  dns_service_ip     = var.dns_service_ip
  docker_bridge_cidr = var.docker_bridge_cidr

  # Addon profile
  aci_connector_linux      = var.aci_connector_linux
  azure_policy             = var.azure_policy
  http_application_routing = var.http_application_routing
  kube_dashboard           = var.kube_dashboard

  # Autoscaler profile
  balance_similar_node_groups      = var.balance_similar_node_groups
  max_graceful_termination_sec     = var.max_graceful_termination_sec
  scan_interval                    = var.scan_interval
  scale_down_delay_after_add       = var.scale_down_delay_after_add
  scale_down_delay_after_delete    = var.scale_down_delay_after_delete
  scale_down_delay_after_failure   = var.scale_down_delay_after_failure
  scale_down_unneeded              = var.scale_down_unneeded
  scale_down_unready               = var.scale_down_unready
  scale_down_utilization_threshold = var.scale_down_utilization_threshold

  tags        = var.tags
  node_labels = var.node_labels

  # Addons node pool
  node_pools = var.node_pools
}
