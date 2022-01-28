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

#############################################################################
# WAF

variable "service_name" {
  type        = string
  description = "Name of the service"
}

variable "description" {
  type        = string
  description = "Description"
  default     = "Managed by Terraform"
}

variable "scope" {
  type        = string
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application"
  default     = "REGIONAL"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the WAF resources"
  default = {
    "made-by" = "terraform"
  }
}
