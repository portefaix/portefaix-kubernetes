# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "2.3.0"

  vnet_name           = var.vnet_name
  resource_group_name = data.azurerm_resource_group.main.name
  address_space       = var.address_space

  subnet_prefixes = var.subnet_prefixes
  subnet_names    = var.subnet_names

  # subnet_service_endpoints = {
  #   subnet2 = ["Microsoft.Storage", "Microsoft.Sql"],
  #   subnet3 = ["Microsoft.AzureActiveDirectory"]
  # }

  tags = var.tags
}
