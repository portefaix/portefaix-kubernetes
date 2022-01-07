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

module "nat_gateway" {
  source  = "terraform-alicloud-modules/nat-gateway/alicloud"
  version = "1.2.0"

  create = true
  name   = var.name
  vpc_id = data.alicloud_vpcs.this.vpcs[0].id

  create_eip = false
}
