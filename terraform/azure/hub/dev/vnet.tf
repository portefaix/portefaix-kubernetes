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

module "hub" {
  source = "../modules/hub"

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location

  vnet_name       = var.vnet_name
  address_space   = var.address_space
  subnet_prefixes = var.subnet_prefixes
  subnet_names    = var.subnet_names

  tags = var.tags
}
