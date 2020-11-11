# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

############################################################################
# Provider

resource_group_name = "portefaix-dev"

############################################################################
# Nat Gateway

nat_gateway_name = "main"

ip_name_1 = "nat_gateway_1_ip_address"

ip_name_2 = "nat_gateway_2_ip_address"

tags = {
    "made-by"  = "terraform"
    "service"  = "nat-gateway"
    "env"      = "dev"
}