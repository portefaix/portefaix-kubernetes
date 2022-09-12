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

data "aws_iam_policy_document" "assume_core_staging" {
 statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [
      format("arn:aws:iam::%s:role/%s", aws_organizations_account.core_staging.id, var.admin_role_name)
    ]
 }
}

resource "aws_iam_group_policy" "assume_core_staging" {
  name   = format("%sAssume%s", title(var.org_name), title(local.core_staging_account))
  group  = var.admin_group_name
  policy = data.aws_iam_policy_document.assume_core_staging.json
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

data "aws_iam_policy_document" "core_staging" {
  provider           = aws.core_staging
  statement {
      actions       = ["sts:AssumeRole"]
      principals {
        type        = "AWS"
        identifiers = [format("arn:aws:iam::%s:root", data.aws_caller_identity.this.account_id)]
      }
  }
}

resource "aws_iam_role" "core_staging" {
  provider           = aws.core_staging
  name               = var.admin_role_name
  assume_role_policy = data.aws_iam_policy_document.core_staging.json
}

resource "aws_iam_role_policy_attachment" "core_staging" {
  provider   = aws.core_staging
  role       = aws_iam_role.core_staging.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}