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
# Application Gateway

hub_rg_name   = "portefaix-dev-hub"
hub_vnet_name = "portefaix-dev-hub"

service_name = "portefaix-dev"

subnet_prefix = "10.0.16.0/20" #"10.10.3.0/24"

tags = {
  "env"               = "dev"
  "project"           = "portefaix"
  "service"           = "applicationgateway"
  "made-by"           = "terraform"
  "portefaix-version" = "v0.43.0"
}
