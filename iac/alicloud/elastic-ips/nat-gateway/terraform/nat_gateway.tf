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

#resource "alicloud_resource_manager_resource_group" "nat_gateway" {
#  name         = format("elastic-ip-%s", var.eip_name)
#  display_name = "EIP Nat Gateway"
#}

resource "alicloud_eip" "nat_gateway" {
  name                 = var.eip_name
  description          = "Created by Terraform"
  bandwidth            = "5"
  internet_charge_type = "PayByBandwidth"
  # resource_group_id    = alicloud_resource_manager_resource_group.nat_gateway.id
  tags = var.tags
}

data "alicloud_vpcs" "main" {
  status     = "Available"
  name_regex = format("^%s", var.vpc_name)
}

data "alicloud_nat_gateways" "main" {
  vpc_id     = data.alicloud_vpcs.main.vpcs.0.id
  name_regex = format("^%s", var.nat_gateway_name)
}

resource "alicloud_eip_association" "main" {
  allocation_id = alicloud_eip.nat_gateway.id
  instance_id   = data.alicloud_nat_gateways.main.gateways.0.id
}
