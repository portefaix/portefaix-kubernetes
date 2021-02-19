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

resource "azurerm_resource_group" "sops" {
  name     = var.sops_resource_group_name
  location = var.sops_resource_group_location
  tags     = var.tags
}

resource "azurerm_key_vault" "sops" {
  name                = format("%s", local.service_name)
  resource_group_name = azurerm_resource_group.sops.name
  location            = azurerm_resource_group.sops.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  tags                = var.tags
}

resource "azurerm_key_vault_access_policy" "object" {
  key_vault_id = azurerm_key_vault.sops.id
  tenant_id    = azurerm_key_vault.sops.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
    "List", "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Decrypt",
    "Encrypt",
  ]

  secret_permissions = [
    "get",
    "list",
    "set",
    "delete",
    "recover",
    "backup",
    "restore",
  ]

  certificate_permissions = [
    "create",
    "delete",
    "deleteissuers",
    "get",
    "getissuers",
    "import",
    "list",
    "listissuers",
    "managecontacts",
    "manageissuers",
    "purge",
    "recover",
    "setissuers",
    "update",
    "backup",
    "restore"
  ]
}

resource "azurerm_key_vault_access_policy" "core" {
  key_vault_id = azurerm_key_vault.sops.id
  tenant_id    = azurerm_key_vault.sops.tenant_id
  object_id    = data.azuread_service_principal.core.id

  key_permissions = [
    "Decrypt",
    "Encrypt",
  ]
}

resource "azurerm_key_vault_key" "sops" {
  name         = format("%s", local.service_name)
  key_vault_id = azurerm_key_vault.sops.id
  key_type     = "RSA"
  key_size     = "4096"

  key_opts = [
    "encrypt",
    "decrypt",
  ]

  tags = var.tags

  depends_on = [azurerm_key_vault_access_policy.object]
}
