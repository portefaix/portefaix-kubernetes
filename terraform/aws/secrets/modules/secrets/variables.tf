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
# Secrets

variable "name" {
  type        = string
  description = "Name of the secret"
}

# variable "automatically_after_days" {
#   type        = number
#   description = "Specifies the number of days between automatic scheduled rotations of the secret"
#   default     = 7
# }

variable "portefaix_version_secret" {
  type        = string
  description = "Version of Portefaix to store into a secret"
}

variable "tags" {
  type        = map(string)
  description = "Tags for AWS resources"
  default = {
    "Made-By" = "terraform"
  }
}
