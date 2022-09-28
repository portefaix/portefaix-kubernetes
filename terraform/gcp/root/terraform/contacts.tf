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

# resource "google_essential_contacts_contact" "essential_contacts" {
#   # Convert a map indexed by category to a map indexed by email
#   # this way is simpler to understand and maintain than the opposite
#   # google_essential_contacts_contact resource needs one email with a list of categories
#   for_each = transpose(local.categories_map)

#   parent                              = data.google_organization.this.id
#   email                               = each.key
#   language_tag                        = var.essential_contacts_language
#   notification_category_subscriptions = each.value
# }