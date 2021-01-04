# Copyright (C) 2020-2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

resource "alicloud_resource_manager_resource_group" "vpc" {
  name         = var.vpc_name
  display_name = "VPC"
}

module "vpc" {
  source  = "alibaba/vpc/alicloud"
  version = "1.8.1"

  region  = var.region
  # profile = var.profile
    
  create            = true

  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_subnet_cidr
  vswitch_name       = var.vswitch_name
  vswitch_cidrs      = var.vswitch_cidrs
  resource_group_id  = alicloud_resource_manager_resource_group.vpc.id     
  availability_zones = var.availability_zones

  vpc_tags     = var.vpc_tags
  vswitch_tags = var.vswitch_tags
    
  # destination_cidrs = var.destination_cidrs
  # nexthop_ids       = var.server_ids
}
