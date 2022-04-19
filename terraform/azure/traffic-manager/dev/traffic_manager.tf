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

module "traffic_manager" {
  source = "../modules/traffic-manager"

  hub_rg_name              = var.hub_rg_name
  appgw_westeurope_ip_name = var.appgw_westeurope_ip_name

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  profile_name            = var.profile_name

  tags = var.tags
}
