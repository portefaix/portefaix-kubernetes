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
# Provider

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags for the AWS provider"
  default = {
    "Project" = "portefaix"
    "Made-By" = "terraform"
  }
}

#############################################################################
# Cognito

variable "service_name" {
  type        = string
  description = "Name of the Cognito service."
}

# variable "cognito_idp_region" {
#   type        = string
#   description = "AWS Region"
# }

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default = {
    "Made-By" = "terraform"
  }
}

# variable "mfa_configuration" {
#   type        = string
#   description = "Multi-Factor Authentication (MFA) configuration for the User Pool."
#   default     = "OPTIONAL"
# }

# variable "callback_urls" {
#   type        = list(string)
#   description = "List of allowed callback URLs for the identity providers"
# }

# variable "logout_urls" {
#   type        = list(string)
#   description = "List of allowed logout URLs for the identity providers."
# }

# variable "google_provider_client_id" {
#   type        = string
#   description = "The Client ID for the Google Provider"
# }

# variable "google_provider_client_secret" {
#   type        = string
#   description = "The Client Secret for the Google Provider"
# }

variable "auth_zero_url" {
  type        = string
  description = "The URL of the Auth0 identity provider"
}

variable "auth_zero_clientid" {
  type        = string
  description = "The Client ID for the Auth0 identity provider"
}

variable "auth_zero_thumbprint" {
  type        = string
  description = "The server certificate thumbprints for the Auth0 identity provider"
}
