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

data "aws_iam_group" "admin" {
  group_name = var.admin_group_name
}

resource "aws_iam_group_policy_attachment" "admin" {
  group      = data.aws_iam_group.admin.group_name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# resource "aws_iam_group_policy" "admin" {
#   group  = var.admin_group_name
#   name   = "PortefaixAdministrator"
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "*",
#       "Resource": "*",
#       "Effect": "Allow",
#       "Sid": "AllowAll"
#     }
#   ]
# }
# EOF
# }
