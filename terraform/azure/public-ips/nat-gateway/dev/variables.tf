# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

#variable subscription_id {
#  type        = string
#  description = "The Subscription ID which should be used"
#}

############################################################################
# IP Addresses

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}

# variable nat_gw_ip_name {
#   type        = string
#   description = "Name of the IP Address"
# }

variable "tags" {
  description = "The tags to associate with the IP addresses."
  type        = map(string)
}
