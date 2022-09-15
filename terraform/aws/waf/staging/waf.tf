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

module "waf" {
  source = "../modules/waf"

  service_name               = var.service_name
  scope                      = var.scope
  cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
  admin_ipv4                 = var.admin_ipv4
  whitelist_ipv4             = var.whitelist_ipv4
  blacklist_ipv4             = var.blacklist_ipv4
  allowed_country_codes      = var.allowed_country_codes

  tags = var.tags
}
