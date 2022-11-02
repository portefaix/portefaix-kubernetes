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

############################################################################
# Provider


############################################################################
# VNet

resource_group_name     = "portefaix-dev-hub"
resource_group_location = "West Europe"

vnet_name = "portefaix-dev-hub"

address_space = ["10.10.0.0/16"]

subnet_prefixes = []
subnet_names    = []

tags = {
  "env"               = "dev"
  "service"           = "hub"
  "project"           = "portefaix"
  "made-by"           = "terraform"
  "portefaix-version" = "v0.43.0"
}
