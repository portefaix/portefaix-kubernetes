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

module "bastion" {
  source  = "kumarvna/azure-bastion/azurerm"
  version = "1.1.0"

  resource_group_name  = azurerm_resource_group.bastion.name
  virtual_network_name = module.vnet.vnet_name

  azure_bastion_service_name          = var.service_name
  azure_bastion_subnet_address_prefix = var.subnet_prefix

  tags = var.tags
}
