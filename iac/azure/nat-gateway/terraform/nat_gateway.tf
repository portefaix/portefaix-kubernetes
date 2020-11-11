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

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_public_ip" "ip_1" {
  name                = var.ip_name_1
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_public_ip" "ip_2" {
  name                = var.ip_name_2
  resource_group_name = data.azurerm_resource_group.main.name
}

resource "azurerm_nat_gateway" "main" {
  name                = var.nat_gateway_name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  sku_name            = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gw_1" {
  nat_gateway_id       = azurerm_nat_gateway.main.id
  public_ip_address_id = data.azurerm_public_ip.ip_1.id
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gw_2" {
  nat_gateway_id       = azurerm_nat_gateway.main.id
  public_ip_address_id = data.azurerm_public_ip.ip_2.id
}
