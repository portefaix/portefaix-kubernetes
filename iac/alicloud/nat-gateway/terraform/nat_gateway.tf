# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

data "alicloud_vpcs" "main" {
  status     = "Available"
  name_regex = format("^%s", var.vpc_name)
}

resource "alicloud_resource_manager_resource_group" "nat_gateway" {
  name         = format("nat-gateway-%s", var.name)
  display_name = "NAT Gateway"
}

resource "alicloud_nat_gateway" "core" {
  name   = var.name
  vpc_id = data.alicloud_vpcs.main.vpcs.0.id
  # tags   = var.tags
}

