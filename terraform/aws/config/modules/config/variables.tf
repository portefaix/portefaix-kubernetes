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
# Project

variable "org_name" {
  type        = string
  description = "Name of the AWS Organization"
}

# variable "audit_account_id" {
#   type        = string
#   description = "ID of the Audit AWS Account"
# }

# variable "logging_account_id" {
#   type        = string
#   description = "ID of the Logging AWS Account"
# }

#############################################################################
# AWS Config

variable "delivery_frequency" {
  type        = string
  description = "The frequency with which AWS Config recurringly delivers configuration snapshots"
  # One_Hour | Three_Hours | Six_Hours | Twelve_Hours | TwentyFour_Hours
  default = "Six_Hours"
}

variable "tags" {
  type        = map(string)
  description = "Tags for AWS resources"
  default = {
    "Made-By" = "Terraform"
  }
}
