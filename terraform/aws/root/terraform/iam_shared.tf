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

data "aws_iam_policy_document" "assume_shared" {
 statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [
      format("arn:aws:iam::%s:role/%s", aws_organizations_account.shared.id, var.admin_role_name)
    ]
 }
}

resource "aws_iam_group_policy" "assume_shared" {
  name   = format("%sAssume%s", title(var.org_name), title(local.shared_account))
  group  = var.admin_group_name
  policy = data.aws_iam_policy_document.assume_shared.json
}

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

data "aws_iam_policy_document" "shared" {
  provider           = aws.shared
  statement {
      actions       = ["sts:AssumeRole"]
      principals {
        type        = "AWS"
        identifiers = [format("arn:aws:iam::%s:root", data.aws_caller_identity.this.account_id)]
      }
  }
}

resource "aws_iam_role" "shared" {
  provider           = aws.shared
  name               = var.admin_role_name
  assume_role_policy = data.aws_iam_policy_document.shared.json
}

resource "aws_iam_role_policy_attachment" "shared" {
  provider   = aws.shared
  role       = aws_iam_role.shared.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}