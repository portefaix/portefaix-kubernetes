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

#############################################################################
# Provider


#############################################################################
# Bastion

hub_rg_name = "portefaix-dev-hub"

appgw_westeurope_ip_name = ""

resource_group_name     = "portefaix-dev-traffic-manager"
resource_group_location = "West Europe"

profile_name = "portefaix-dev"

tags = {
  "env"     = "dev"
  "project" = "portefaix"
  "service" = "bastion"
  "made-by" = "terraform"
}
