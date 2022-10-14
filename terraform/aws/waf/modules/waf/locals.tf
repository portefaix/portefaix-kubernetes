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

locals {
  acl_core_name = format("%s-core", var.service_name)

  waf_header                   = "x-portefaix-waf"
  waf_custom_response_body_key = format("waf-%s", var.service_name)

  ip_set_admin_name     = format("%s-admin", var.service_name)
  ip_set_whitelist_name = format("%s-whitelist", var.service_name)
  ip_set_blacklist_name = format("%s-blacklist", var.service_name)

  rule_whitelist_country_name = format("waf-%s-WhitelistByCountry", var.service_name)
  rule_whitelist_ips          = format("waf-%s-WhitelistByCIDRs", var.service_name)
  rule_blacklist_ips          = format("waf-%s-BlacklistByCIDRs", var.service_name)
  rule_ip_rate                = format("waf-%s-IPRate", var.service_name)
}
