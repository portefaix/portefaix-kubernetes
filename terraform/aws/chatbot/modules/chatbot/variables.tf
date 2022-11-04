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
# AWS ChatBot

variable "name" {
  type        = string
  description = "Name of Slack channel configuration in AWS Chatbot."
}

variable "slack_workspace_id" {
  type        = string
  description = "ID of the Slack workspace containing the channel to use with AWS Chatbot"
}

variable "slack_channel_id" {
  type        = string
  description = "ID of the Slack channel configure with AWS Chatbot"
}

variable "log_level" {
  type        = string
  default     = "INFO"
  description = "Log level AWS Chatbot should use. Possible values are ERROR, INFO, NONE"
}

variable "allow_notifications" {
  type        = bool
  default     = true
  description = "Grant read access for CloudWatch to AWS Chatbot."
}

variable "allow_labmda_invoke" {
  type        = bool
  default     = false
  description = "Allow users to invoke Lambda functions from Slack."
}

variable "allow_support_access" {
  type        = bool
  default     = false
  description = "Allow users to interact with AWS support from Slack."
}

variable "allow_read_only_access" {
  type        = bool
  default     = false
  description = "Provide users with read access to all AWS resources from within Slack."
}

# variable "role_permissions_boundary_policy_arn" {
#   type        = string
#   default     = ""
#   description = "IAM policy document to use as permissions boundary in the Chatbot IAM role."
# }

variable "tags" {
  type        = map(string)
  description = "Tags for AWS resources"
  default = {
    "Service" = "AWS ChatBot"
  }
}

variable "sns_create_topic" {
  description = "Whether to create the SNS topic"
  type        = bool
  default     = true
}

variable "display_name" {
  description = "The display name for the SNS topic"
  type        = string
  default     = "Managed by Terraform"
}
