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

# Services

resource "aws_iam_user" "github_actions" {
  name          = "github.actions"
  path          = "/"
  force_destroy = true

  tags = merge({
    "Name"    = "github.actions",
    "Service" = "IAM"
    },
    var.tags
  )
}

resource "aws_iam_user_group_membership" "github_actions" {
  user = aws_iam_user.github_actions.name
  groups = [
    data.aws_iam_group.admin.group_name
  ]
}

resource "aws_iam_access_key" "github_actions" {
  user = aws_iam_user.github_actions.name
}

# Team

resource "aws_iam_user" "nicolas_lamirault" {
  name          = "nicolas.lamirault"
  path          = "/"
  force_destroy = true

  tags = merge({
    "Name"    = "nicolas.lamirault",
    "Service" = "IAM"
    },
    var.tags
  )
}

resource "aws_iam_user_group_membership" "nicolas_lamirault" {
  user = aws_iam_user.nicolas_lamirault.name
  groups = [
    data.aws_iam_group.admin.group_name
  ]
}
