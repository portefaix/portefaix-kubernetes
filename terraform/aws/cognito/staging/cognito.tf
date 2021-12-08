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

module "cognito" {
  source = "../modules/cognito"

  service_name       = var.service_name
  cognito_idp_region = var.cognito_idp_region
  tags               = var.tags

  mfa_configuration = var.mfa_configuration
  callback_urls     = var.callback_urls
  logout_urls       = var.logout_urls

  # google_provider_client_id     = var.google_provider_client_id
  # google_provider_client_secret = var.google_provider_client_secret

  auth_zero_url        = var.auth_zero_url
  auth_zero_clientid   = var.auth_zero_clientid
  auth_zero_thumbprint = var.auth_zero_thumbprint
}
