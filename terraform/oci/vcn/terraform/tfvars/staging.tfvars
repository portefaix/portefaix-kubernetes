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

#####################################################################""
# Provider

region = "uk-london-1"

##############################################################################
# Virtual Cloud Network

label_prefix = "portefaix-staging"

vcn_name  = "core"
vcn_cidrs = ["10.30.0.0/16"]

create_internet_gateway       = true
internet_gateway_display_name = "portefaix-staging"

create_nat_gateway       = true
nat_gateway_display_name = "portefaix-staging"

create_service_gateway       = true
service_gateway_display_name = "portefaix-staging"

freeform_tags = {
  project = "portefaix-staging"
  env     = "staging"
  service = "vcn"
  made-by = "terraform"
}

# Subnets

# control_plane_cidr = "10.30.00.0/24"
# workers_cidr = "10.30.10.0/24"
# pub_lb_cidr = "10.30.20.0/24"
# int_lb_cidr = "10.30.30.0/24"
