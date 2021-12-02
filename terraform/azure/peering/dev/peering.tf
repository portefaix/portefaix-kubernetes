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

module "peering" {
  source = "../modules/peering"

  # resource_group_name     = var.resource_group_name
  # resource_group_location = var.resource_group_location

  core_rg_name      = var.core_rg_name
  core_vnet_name    = var.core_vnet_name
  bastion_rg_name   = var.bastion_rg_name
  bastion_vnet_name = var.bastion_vnet_name
}
