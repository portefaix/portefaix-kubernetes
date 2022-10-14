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

resource "aws_iam_account_alias" "audit" {
  provider      = aws.audit
  account_alias = format("%s-%s", var.org_name, local.audit_account)
}

resource "aws_iam_account_password_policy" "audit" {
  provider                       = aws.audit
  allow_users_to_change_password = true
  hard_expiry                    = false
  max_password_age               = 90
  minimum_password_length        = 15
  password_reuse_prevention      = 5
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
}

resource "aws_iam_account_alias" "core_prod" {
  provider      = aws.core_prod
  account_alias = format("%s-%s", var.org_name, local.core_prod_account)
}

resource "aws_iam_account_password_policy" "core_prod" {
  provider                       = aws.core_prod
  allow_users_to_change_password = true
  hard_expiry                    = false
  max_password_age               = 90
  minimum_password_length        = 15
  password_reuse_prevention      = 5
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
}

resource "aws_iam_account_alias" "core_staging" {
  provider      = aws.core_staging
  account_alias = format("%s-%s", var.org_name, local.core_staging_account)
}

resource "aws_iam_account_password_policy" "core_staging" {
  provider                       = aws.core_staging
  allow_users_to_change_password = true
  hard_expiry                    = false
  max_password_age               = 90
  minimum_password_length        = 15
  password_reuse_prevention      = 5
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
}

resource "aws_iam_account_alias" "core_dev" {
  provider      = aws.core_dev
  account_alias = format("%s-%s", var.org_name, local.core_dev_account)
}

resource "aws_iam_account_password_policy" "core_dev" {
  provider                       = aws.core_dev
  allow_users_to_change_password = true
  hard_expiry                    = false
  max_password_age               = 90
  minimum_password_length        = 15
  password_reuse_prevention      = 5
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
}

resource "aws_iam_account_alias" "logging" {
  provider      = aws.logging
  account_alias = format("%s-%s", var.org_name, local.logging_account)
}

resource "aws_iam_account_password_policy" "logging" {
  provider                       = aws.logging
  allow_users_to_change_password = true
  hard_expiry                    = false
  max_password_age               = 90
  minimum_password_length        = 15
  password_reuse_prevention      = 5
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
}

resource "aws_iam_account_alias" "network" {
  provider      = aws.network
  account_alias = format("%s-%s", var.org_name, local.network_account)
}

resource "aws_iam_account_password_policy" "network" {
  provider                       = aws.network
  allow_users_to_change_password = true
  hard_expiry                    = false
  max_password_age               = 90
  minimum_password_length        = 15
  password_reuse_prevention      = 5
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
}

# resource "aws_iam_account_alias" "security" {
#   provider      = aws.security
#   account_alias = format("%s-%s", var.org_name, local.security_account)
# }

# resource "aws_iam_account_password_policy" "security" {
#   provider                       = aws.security
#   allow_users_to_change_password = true
#   hard_expiry                    = false
#   max_password_age               = 90
#   minimum_password_length        = 15
#   password_reuse_prevention      = 5
#   require_lowercase_characters   = true
#   require_numbers                = true
#   require_symbols                = true
#   require_uppercase_characters   = true
# }

resource "aws_iam_account_alias" "shared" {
  provider      = aws.shared
  account_alias = format("%s-%s", var.org_name, local.shared_account)
}

resource "aws_iam_account_password_policy" "shared" {
  provider                       = aws.shared
  allow_users_to_change_password = true
  hard_expiry                    = false
  max_password_age               = 90
  minimum_password_length        = 15
  password_reuse_prevention      = 5
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
}
