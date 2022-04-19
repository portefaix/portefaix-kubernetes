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

module "vpc" {
  source  = "alibaba/vpc/alicloud"
  version = "1.10.0"

  region = var.region
  # profile = var.profile

  create = true

  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_subnet_cidr
  vpc_description    = var.vpc_description
  vswitch_name       = var.vswitch_name
  vswitch_cidrs      = var.vswitch_cidrs
  availability_zones = var.availability_zones

  #resource_group_id  = alicloud_resource_manager_resource_group.vpc.id

  vpc_tags            = var.vpc_tags
  vswitch_description = var.vswitch_description
  vswitch_tags        = var.vswitch_tags

  #   destination_cidrs = var.destination_cidrs
  #   nexthop_ids       = var.server_ids
}

resource "alicloud_vswitch" "pod_vswitch" {
  count        = length(var.pod_vswitch_cidrs)
  vswitch_name = format("%s-pod-%s", var.pod_vswitch_name, count.index)
  vpc_id       = module.vpc.this_vpc_id
  cidr_block   = var.pod_vswitch_cidrs[count.index]
  zone_id      = var.availability_zones[count.index]
  tags         = var.pod_vswitch_tags
}
