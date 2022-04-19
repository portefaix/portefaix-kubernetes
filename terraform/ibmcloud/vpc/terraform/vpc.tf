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
  source  = "terraform-ibm-modules/vpc/ibm//modules/vpc"
  version = "1.1.1"

  resource_group_id = data.ibm_resource_group.this.id

  create_vpc                  = true
  vpc_name                    = var.vpc_name
  classic_access              = var.classic_access
  default_address_prefix      = var.default_address_prefix
  default_network_acl_name    = var.default_network_acl_name
  default_security_group_name = var.default_security_group_name
  default_routing_table_name  = var.default_routing_table_name
  vpc_tags                    = var.vpc_tags
  address_prefixes            = var.address_prefixes
  locations                   = var.locations
  subnet_name                 = var.subnet_name
  number_of_addresses         = var.number_of_addresses
  create_gateway              = var.create_gateway
  public_gateway_name         = var.public_gateway_name
  # floating_ip                 = var.floating_ip
  gateway_tags = var.gateway_tags
}
