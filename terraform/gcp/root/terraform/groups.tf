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

# module "required_group" {
#   for_each = local.required_groups_to_create
  
#   source  = "terraform-google-modules/group/google"
#   version = "v0.4.0"

#   providers = {
#     google = google-beta
#   }

#   id                   = each.value
#   display_name         = each.key
#   description          = each.key
#   initial_group_config = var.initial_group_config
#   customer_id          = data.google_organization.this.directory_customer_id
# }

# module "optional_group" {
#   for_each = local.optional_groups_to_create

#   source  = "terraform-google-modules/group/google"
#   version = "v0.4.0"

#   providers = {
#     google = google-beta
#   }

#   id                   = each.value
#   display_name         = each.key
#   description          = each.key
#   initial_group_config = var.initial_group_config
#   customer_id          = data.google_organization.this.directory_customer_id
# }