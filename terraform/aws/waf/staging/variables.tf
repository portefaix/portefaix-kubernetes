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

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags for the AWS provider"
  default = {
    "Project"           = "Portefaix"
    "Made-By"           = "Terraform"
    "Portefaix-Version" = "v0.41.0"
  }
}

#############################################################################
# Project

variable "org_name" {
  type        = string
  description = "Name of the AWS Organization"
}

variable "core_account_id" {
  type        = string
  description = "ID of the Core AWS Account"
}

#############################################################################
# WAF

variable "service_name" {
  type        = string
  description = "Name of the service"
}

variable "scope" {
  type        = string
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application"
  default     = "REGIONAL"
}

variable "cloudwatch_metrics_enabled" {
  type        = bool
  description = "Indicating whether the associated resource sends metrics to CloudWatch"
  default     = false
}

variable "admin_ipv4" {
  description = "Allow Admins IP addresses for IPV4 addresses"
  type        = list(string)
  default     = []
}

variable "whitelist_ipv4" {
  description = "Allow whitelist for IPV4 addresses"
  type        = list(string)
  default     = []
}

variable "blacklist_ipv4" {
  description = "Block blacklist for IPV4 addresses"
  type        = list(string)
  default     = []
}

variable "allowed_country_codes" {
  description = "Whitelist access by country"
  type        = list(string)
  default     = []
}
variable "tags" {
  type        = map(string)
  description = "Tags for the WAF resources"
  default = {
    "Service" = "WAF"
  }
}
