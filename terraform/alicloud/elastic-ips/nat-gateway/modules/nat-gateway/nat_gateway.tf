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

module "eip_nat_gateway" {
  source  = "terraform-alicloud-modules/eip/alicloud//modules/associate-with-nat-gateway"
  version = "1.2.0"

  create               = true
  number_of_eips       = 1
  name                 = var.eip_name
  bandwidth            = 5
  internet_charge_type = "PayByTraffic"
  instance_charge_type = "PostPaid"
  period               = 1
  isp                  = var.isp
  name_regex           = var.nat_gateway_name
  tags                 = var.tags
}

# resource "alicloud_eip_association" "this" {
#   allocation_id = module.eip_nat_gateway.this_eip_id
#   instance_id   = data.alicloud_nat_gateways.this.gateways[0].id
# }
