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

module "gh_oidc" {
  source  = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version = "3.1.0"

  project_id            = var.project_id
  pool_id               = var.pool_id
  pool_display_name     = var.pool_display_name
  pool_description      = var.pool_description
  provider_id           = var.provider_id
  provider_display_name = var.provider_display_name
  provider_description  = var.provider_description
  sa_mapping            = var.sa_mapping
}
