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

#####################################################################""
# Provider


############################################################################
# VPC

variable "name" {
  type        = string
  description = "A name for the VPC"
}

variable "region" {
  type        = string
  description = "The DigitalOcean region slug for the VPC's location"
}

variable "subscription_tier_slug" {
  type        = string
  description = "The slug identifier for the subscription tier to use"
  default     = "basic"
}
