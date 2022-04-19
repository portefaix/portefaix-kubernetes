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

######################################################################
# Provider

project = "portefaix-dev"

region = "europe-west1"

##############################################################################
# VPC

network_name  = "portefaix-dev"
subnet_name   = "portefaix-dev"
subnet_region = "europe-west1"
subnet_cidr   = "10.10.0.0/20"

secondary_ranges = {
  portefaix-dev = [
    {
      range_name    = "portefaix-dev-gke-services"
      ip_cidr_range = "10.40.16.0/20"
    },
    {
      range_name    = "portefaix-dev-gke-pods"
      ip_cidr_range = "10.40.32.0/20"
    },
  ]
}
