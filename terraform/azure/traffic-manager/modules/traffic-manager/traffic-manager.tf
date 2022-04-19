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
  source  = "guidalabs/traffic-manager/azure"
  version = "0.1.1"

  resource_group_name    = azurerm_resource_group.this.name
  profile_name           = var.profile_name
  traffic_routing_method = "MultiValue"
  max_return             = 3
  monitor_port           = 6001

  traffic_manager_endpoints = {
    appgw_westeurope = {
      target_ip = data.azurerm_public_ip.appgw_westeurope.ip_address
      weight    = "100"
    },
    # appgw_northeurope = {
    #   target_ip = "2.2.2.2"
    #   weight    = "101"
    # },
  }

  tags = var.tags
}
