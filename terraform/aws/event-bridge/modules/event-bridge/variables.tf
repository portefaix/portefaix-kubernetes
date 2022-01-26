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
# Event Bridge

variable "bus_name" {
  description = "A unique name for your EventBridge Bus"
  type        = string
}

# variable "rules" {
#   description = "A map of objects with EventBridge Rule definitions."
#   type        = map(any)
#   default     = {}
# }

# variable "targets" {
#   description = "A map of objects with EventBridge Target definitions."
#   type        = any
#   default     = {}
# }

# variable "archives" {
#   description = "A map of objects with the EventBridge Archive definitions."
#   type        = map(any)
#   default     = {}
# }

# variable "permissions" {
#   description = "A map of objects with EventBridge Permission definitions."
#   type        = map(any)
#   default     = {}
# }

# variable "connections" {
#   description = "A map of objects with EventBridge Connection definitions."
#   type        = any
#   default     = {}
# }

# variable "api_destinations" {
#   description = "A map of objects with EventBridge Destination definitions."
#   type        = map(any)
#   default     = {}
# }

variable "tags" {
  type        = map(string)
  description = "Tags for AWS resources"
  default = {
    "Made-By" = "terraform"
  }
}

#############################################################################
# SNS

variable "sns_security_topic_name" {
  type        = string
  description = "Name of SNS topic for AWS SecurityHub."
}

variable "sns_chatbot_topic_name" {
  type        = string
  description = "Name of SNS topic for AWS ChatBot."
}
