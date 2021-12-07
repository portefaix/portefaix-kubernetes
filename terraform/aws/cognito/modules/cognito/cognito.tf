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

resource "aws_cognito_user_pool" "this" {
  name = var.service_name

  alias_attributes         = ["email", "preferred_username", "phone_number"]
  auto_verified_attributes = ["email", "phone_number"]

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  sms_authentication_message = "Your code is {####}"

  sms_configuration {
    external_id    = format("%s-sns-external-id", var.service_name)
    sns_caller_arn = aws_iam_role.cognito_sns.arn
  }

  password_policy {
    minimum_length    = 6
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  username_configuration {
    case_sensitive = false
  }

  mfa_configuration = var.mfa_configuration

  software_token_mfa_configuration {
    enabled = true
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true

    string_attribute_constraints {
      min_length = 7
      max_length = 256
    }
  }

  schema {
    name                     = "name"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true

    string_attribute_constraints {
      min_length = 3
      max_length = 256
    }
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }

    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  tags = merge({
    "Name" = var.service_name
  }, var.tags)

  depends_on = [
    aws_iam_role.cognito_sns,
  ]
}

resource "aws_cognito_user_pool_client" "this" {
  depends_on = [
    aws_cognito_identity_provider.google,
  ]

  user_pool_id           = aws_cognito_user_pool.this.id
  name                   = var.service_name
  generate_secret        = true
  refresh_token_validity = 30
  explicit_auth_flows    = ["ADMIN_NO_SRP_AUTH", "USER_PASSWORD_AUTH"]

  # this flag is automatically set to true when creating the user pool using the AWS console.
  # however, when creating the user pool using Terraform, this flag needs to be set explicitly.
  allowed_oauth_flows_user_pool_client = true

  # issue: https://github.com/terraform-providers/terraform-provider-aws/issues/4476
  read_attributes  = ["email", "preferred_username", "profile", "custom:some_custom_attribute"]
  write_attributes = ["email", "preferred_username", "profile", "custom:some_custom_attribute"]

  supported_identity_providers = ["COGNITO", "Google"]
  callback_urls                = var.callback_urls
  logout_urls                  = var.logout_urls
  allowed_oauth_flows          = ["code"]

  allowed_oauth_scopes = [
    "aws.cognito.signin.user.admin",
    "email",
    "openid",
    "profile",
  ]
}

resource "aws_cognito_identity_pool" "this" {
  identity_pool_name               = var.service_name
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.this.id
    provider_name           = "cognito-idp.${var.cognito_idp_region}.amazonaws.com/${aws_cognito_user_pool.this.id}"
    server_side_token_check = false
  }

  supported_login_providers = {
    "accounts.google.com" = var.google_provider_client_id
  }

  depends_on = [
    aws_cognito_user_pool.this,
  ]
}

resource "aws_cognito_identity_pool_roles_attachment" "this" {
  identity_pool_id = aws_cognito_identity_pool.this.id
  roles = {
    authenticated = aws_iam_role.authenticated.arn
    # unauthenticated = aws_iam_role.unauthenticated.arn
  }

  role_mapping {
    identity_provider         = "accounts.google.com"
    ambiguous_role_resolution = "AuthenticatedRole"
    type                      = "Rules"

    mapping_rule {
      claim      = "isAdmin"
      match_type = "Equals"
      role_arn   = aws_iam_role.authenticated.arn
      value      = "paid"
    }
  }

  #  role_mapping {
  #   identity_provider         = "graph.facebook.com"
  #   ambiguous_role_resolution = "AuthenticatedRole"
  #   type                      = "Rules"

  #   mapping_rule {
  #     claim      = "isAdmin"
  #     match_type = "Equals"
  #     role_arn   = aws_iam_role.authenticated.arn
  #     value      = "paid"
  #   }
  # }

}
