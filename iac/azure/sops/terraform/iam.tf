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
  location            = data.azurerm_kubernetes_cluster.aks.location
  tags                = var.tags
}

#resource "azurerm_role_assignment" "operator" {
#  # DTS Bootstrap Principal_id
#  principal_id         = azurerm_user_assigned_identity.sops.principal_id
#  role_definition_name = "Managed Identity Operator"
#  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.azurerm_resource_group.genesis_rg.name}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${azurerm_user_assigned_identity.sops-mi.name}"
#}

resource "azurerm_role_assignment" "reader" {
  # DTS Bootstrap Principal_id
  principal_id         = azurerm_user_assigned_identity.sops.principal_id
  role_definition_name = "Reader"
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${azurerm_resource_group.sops.name}/providers/Microsoft.KeyVault/vaults/${azurerm_key_vault.sops.name}"
}

resource "azurerm_key_vault_access_policy" "sops-policy" {
  key_vault_id = azurerm_key_vault.sops.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.sops.principal_id

  key_permissions = [
    "get",
    "encrypt",
    "decrypt",
    "list",
  ]

  secret_permissions = [
    "get",
    "list",
  ]
}
