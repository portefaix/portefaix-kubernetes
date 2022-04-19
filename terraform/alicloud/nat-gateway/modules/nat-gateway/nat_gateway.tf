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

module "nat_gateway" {
  # source  = "terraform-alicloud-modules/nat-gateway/alicloud"
  # version = "1.2.0"
  # See:
  # https://github.com/terraform-alicloud-modules/terraform-alicloud-nat-gateway/pull/5
  # https://github.com/terraform-alicloud-modules/terraform-alicloud-nat-gateway/pull/9
  source = "git::https://github.com/nlamirault/terraform-alicloud-nat-gateway.git?ref=feat/alicloud-ng"

  create               = true
  name                 = var.name
  vpc_id               = data.alicloud_vpcs.this.vpcs[0].id
  vswitch_id           = data.alicloud_vswitches.this.vswitches[0].id
  nat_type             = "Enhanced"
  internet_charge_type = "PayByLcu"

  nat_tags = var.tags

  create_eip = false
}
