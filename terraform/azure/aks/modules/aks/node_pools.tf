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

# https://github.com/Azure/terraform-azurerm-aks/pull/212
resource "azurerm_kubernetes_cluster_node_pool" "aks" {
  for_each = { for pool in var.node_pools : pool.name => pool }

  vnet_subnet_id        = data.azurerm_subnet.aks.id
  kubernetes_cluster_id = module.aks.aks_id

  zones = var.agents_availability_zones

  name                  = each.value.name
  os_type               = "Linux"
  priority              = each.value.priority
  vm_size               = each.value.vm_size
  os_disk_size_gb       = each.value.os_disk_size_gb
  os_disk_type          = each.value.os_disk_type
  enable_auto_scaling   = each.value.enable_auto_scaling
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  node_count            = each.value.count
  max_pods              = each.value.max_pods
  node_labels           = each.value.labels
  node_taints           = each.value.taints
  tags                  = each.value.tags
  enable_node_public_ip = false
}
