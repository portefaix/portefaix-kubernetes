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

resource "azurerm_subnet" "this" {
  name                 = "ApplicationGatewaySubnet"
  resource_group_name  = data.azurerm_resource_group.hub.name
  virtual_network_name = data.azurerm_virtual_network.hub.name
  address_prefixes     = [var.subnet_prefix]
}

resource "azurerm_public_ip" "this" {
  name                = format("%s-application-gateway", var.service_name)
  resource_group_name = data.azurerm_resource_group.hub.name
  location            = data.azurerm_resource_group.hub.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}
