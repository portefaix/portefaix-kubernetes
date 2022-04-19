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

module "cloud_nat" {
  source = "../modules/cloud-nat"

  project         = var.project
  region          = var.region
  nat_name        = var.nat_name
  nat_router_name = var.nat_router_name
  nat_network     = var.nat_network
  nat_ips = [
    data.google_compute_address.external_ip_0.self_link,
    data.google_compute_address.external_ip_1.self_link,
  ]
  min_ports_per_vm = var.min_ports_per_vm
}
