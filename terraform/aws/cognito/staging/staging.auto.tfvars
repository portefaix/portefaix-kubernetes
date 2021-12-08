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

region = "eu-west-3"

#############################################################################
# Cognito

service_name       = "portefaix-staging"
cognito_idp_region = "eu-west-3"

tags = {
  "Project" = "portefaix"
  "Env"     = "staging"
  "Service" = "cognito"
  "Made-By" = "terraform"
}

# mfa_configuration = "ON"
callback_urls = []
logout_urls   = []

# google_provider_client_id     = "xxxx"
# google_provider_client_secret = "xxxx"

auth_zero_url      = "https://portefaix.eu.auth0.com"
auth_zero_clientid = "3qW0aMNZY20Z4ukqzmI5IaRXCHgkDH1e"
# See: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html
auth_zero_thumbprint = "B3DD7606D2B5A8B4A13771DBECC9EE1CECAFA38A"
