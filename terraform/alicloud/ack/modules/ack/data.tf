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

data "alicloud_vpcs" "this" {
  status     = "Available"
  name_regex = format("^%s", var.vpc_name)
}

data "alicloud_vswitches" "this" {
  vpc_id     = data.alicloud_vpcs.this.vpcs[0].id
  name_regex = format("^%s", var.vswitch_name)
}

data "alicloud_vswitches" "pods" {
  vpc_id     = data.alicloud_vpcs.this.vpcs[0].id
  name_regex = format("^%s", var.pod_vswitch_name)
}
