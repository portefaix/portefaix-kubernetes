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
  source  = "terraform-google-modules/network/google"
  version = "5.2.0"

  project_id   = var.project
  network_name = var.network_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = var.subnet_name
      subnet_ip     = var.subnet_cidr
      subnet_region = var.subnet_region
    }
  ]

  secondary_ranges = var.secondary_ranges

  # routes = [
  #   {
  #     name              = "egress-internet"
  #     description       = "route through IGW to access internet"
  #     destination_range = "0.0.0.0/0"
  #     tags              = "egress-inet"
  #     next_hop_internet = "true"
  #   },
  #   {
  #     name                   = "app-proxy"
  #     description            = "route through proxy to reach app"
  #     destination_range      = "10.50.10.0/24"
  #     tags                   = "app-proxy"
  #     next_hop_instance      = "app-proxy-instance"
  #     next_hop_instance_zone = "us-west1-a"
  #   },
  # ]
}
