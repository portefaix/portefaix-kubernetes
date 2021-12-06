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

# https://github.com/Azure/terraform-azurerm-aks/pull/127
resource "azurerm_kubernetes_cluster_node_pool" "aks" {
  for_each = toset(var.node_pools)

  vnet_subnet_id        = data.azurerm_subnet.nodes.id
  kubernetes_cluster_id = module.aks.aks_id

  availability_zones = var.agents_availability_zones

  name                  = each.value.name
  os_type               = "Linux"
  vm_size               = each.value.agents_vm_size
  os_disk_size_gb       = each.value.agents_disk_size_gb
  os_disk_type          = each.value.agents_disk_type
  enable_auto_scaling   = each.value.enable_auto_scaling
  min_count             = each.value.agents_min_count
  max_count             = each.value.agents_max_count
  node_count            = each.value.agents_count
  max_pods              = each.value.agents_max_pods
  node_labels           = each.value.agents_labels
  node_taints           = each.value.agents_taints
  tags                  = each.value.agents_tags
  enable_node_public_ip = false
}
