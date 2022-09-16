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

#tfsec:ignore:aws-iam-enforce-mfa
# resource "aws_iam_group" "enforce_mfa" {
#   name = "EnforceMFA"
# }

#tfsec:ignore:aws-iam-enforce-mfa
resource "aws_iam_group" "sre" {
  name = "TeamSRE"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "sre" {
  group      = aws_iam_group.sre.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#tfsec:ignore:aws-iam-enforce-mfa
resource "aws_iam_group" "dev" {
  name = "TeamDevelopment"
  path = "/"
}

#tfsec:ignore:aws-iam-enforce-mfa
resource "aws_iam_group" "billing" {
  name = "TeamBilling"
  path = "/"
}
