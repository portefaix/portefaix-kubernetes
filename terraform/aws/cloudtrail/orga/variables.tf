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

variable "audit_account_id" {
  type        = string
  description = "ID of the Audit AWS Account"
}

#############################################################################
# Cloudtrail

variable "cloudtrail_bucket_name" {
  type        = string
  description = "Bucket name of Cloudtrail logs"
}

variable "cloudtrail_topic_name" {
  type        = string
  description = "SNS topic name of Cloudtrail"
}

variable "cloudtrail_logging" {
  type        = bool
  description = "Enables logging for the trail"
}

#############################################################################
# Kinesis

# variable "stream_name" {
#   type        = string
#   description = "Kinesis stream name"
# }

# variable "shard_count" {
#   description = "Number of shards to use in the Kinesis stream"
#   type        = number
#   default     = 4
# }

# variable "retention_period" {
#   description = "Retention period of the Kinesis stream (in days)"
#   type        = number
#   default     = 7
# }


#############################################################################
# Commons

variable "tags" {
  type        = map(string)
  description = "Tags for AWS resources"
  default = {
    "Service" = "Cloudtrail"
  }
}
