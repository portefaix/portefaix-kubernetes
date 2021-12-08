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

# resource "aws_cognito_identity_provider" "google" {
#   user_pool_id  = aws_cognito_user_pool.this.id
#   provider_name = "Google"
#   provider_type = "Google"

#   provider_details = {
#     authorize_scopes = "profile email openid"
#     client_id        = var.google_provider_client_id
#     client_secret    = var.google_provider_client_secret
#   }

#   attribute_mapping = {
#     email    = "email"
#     username = "sub"
#   }
# }

# resource "aws_cognito_identity_provider" "auth0" {
#   user_pool_id  = aws_cognito_user_pool.this.id
#   provider_name = "Auth0"
#   provider_type = "OIDC"

#   attribute_mapping = {
#     email = "email"
#     family_name = "family_name"
#     given_name = "given_name"
#     username = "sub"
#   }

#   provider_details = {
#     attributes_request_method     = "POST"
#     attributes_url_add_attributes = "false"
#     authorize_scopes              = "email openid profile"
#     client_id                     = var.auth0_provider_idp_client_id
#     client_secret                 = var.auth0_provider_idp_client_secret
#     oidc_issuer                   = var.auth0_provider_idp_oidc_issuer
#   }
# }

resource "aws_iam_openid_connect_provider" "auth_zero" {
  url = var.auth_zero_url

  client_id_list = [
    var.auth_zero_clientid
  ]

  thumbprint_list = [
    var.auth_zero_thumbprint
  ]

  tags = var.tags
}
