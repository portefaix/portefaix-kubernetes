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

# resource "azurerm_management_group" "root" {
#   display_name = var.organization

#   subscription_ids = [
#     data.azurerm_subscription.this.subscription_id,
#   ]
# }

resource "azurerm_management_group" "security" {
  display_name               = "Security"
  # parent_management_group_id = azurerm_management_group.root.id

  subscription_ids = [
    data.azurerm_subscription.this.subscription_id,
  ]
}

resource "azurerm_management_group" "shared" {
  display_name               = "Shared"
  # parent_management_group_id = azurerm_management_group.root.id

  subscription_ids = [
    data.azurerm_subscription.this.subscription_id,
  ]
}

resource "azurerm_management_group" "core" {
  display_name               = "Core"
  # parent_management_group_id = azurerm_management_group.root.id

  subscription_ids = [
    data.azurerm_subscription.this.subscription_id,
  ]
}

resource "azurerm_management_group" "suspended" {
  display_name               = "Suspended"
  # parent_management_group_id = azurerm_management_group.root.id

  subscription_ids = [
    data.azurerm_subscription.this.subscription_id,
  ]
}