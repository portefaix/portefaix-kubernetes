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

#######################################################################
# Provider

# variable "cloudflare_r2_access_key_id" {
#   type = string
# }
# variable "cloudflare_r2_secret_access_key" {
#   type = string
#   sensitive = true
# }

variable "cloudflare_account_id" {
  description = "The Cloudflare account ID"
  type        = string
}


#######################################################################
# Observability

variable "buckets" {
  description = "List of buckets names"
  type        = list(string)
}
