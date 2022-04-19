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

#####################################################################""
# Provider

region = "eu-gb"


##############################################################################
# VPC

resource_group_name = "portefaix-staging"

vpc_name                    = "portefaix-staging"
subnet_name                 = "portefaix-staging"
default_network_acl_name    = "portefaix-staging"
default_security_group_name = "portefaix-staging"
default_routing_table_name  = "portefaix-staging"

classic_access = false

default_address_prefix = "auto"

locations = ["eu-gb-1", "eu-gb-2", "eu-gb-3"]
address_prefixes = [
  {
    name     = "prefix-1"
    location = "eu-gb-1"
    ip_range = "10.0.0.0/18"
  },
  {
    name     = "prefix-2"
    location = "eu-gb-2"
    ip_range = "10.0.64.0/18"
  },
  {
    name     = "prefix-3"
    location = "eu-gb-3"
    ip_range = "10.0.128.0/18"
  },
]
number_of_addresses = 4096

vpc_tags = ["terraform", "vpc"]

create_gateway      = true
public_gateway_name = "portefaix-staging"
gateway_tags        = ["terraform", "gateway"]

# public_ip_id = "319fefed-ec67-4a5c-a83d-a09d0da91e36"
