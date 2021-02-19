# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

resource "azurerm_user_assigned_identity" "sops" {
  name                = local.service_name
  resource_group_name = azurerm_resource_group.sops.name
  location            = azurerm_resource_group.sops.location
  tags                = var.tags
}

resource "azurerm_role_assignment" "sops" {
  scope                = azurerm_key_vault.sops.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.sops.principal_id
}

resource "azurerm_key_vault_access_policy" "sops" {
  key_vault_id = azurerm_key_vault.sops.id
  tenant_id    = azurerm_key_vault.sops.tenant_id
  object_id    = azurerm_user_assigned_identity.sops.principal_id

  key_permissions = [
    "Decrypt",
    "Encrypt",
  ]
}
