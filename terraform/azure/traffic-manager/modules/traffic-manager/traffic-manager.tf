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

resource "azurerm_traffic_manager_profile" "this" {
  name                   = var.profile_name
  resource_group_name    = var.resource_group_name
  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = var.profile_name
    ttl           = var.dns_ttl
  }

  monitor_config {
    protocol                     = var.monitor_protocol
    port                         = var.monitor_port
    path                         = var.monitor_path
    interval_in_seconds          = var.monitor_probe_interval
    timeout_in_seconds           = var.monitor_probe_timeout
    tolerated_number_of_failures = var.monitor_tolerated_failures
  }

  tags = var.tags
}

resource "azurerm_traffic_manager_azure_endpoint" "example" {
  name               = var.profile_name
  profile_id         = azurerm_traffic_manager_profile.this.id
  weight             = 100
  target_resource_id = data.azurerm_public_ip.appgw_westeurope.id
}
