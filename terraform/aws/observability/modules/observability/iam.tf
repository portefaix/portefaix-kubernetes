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

# resource "aws_iam_role" "grafana_shared" {
#   provider           = aws.shared
#   name               = local.service_name
#   assume_role_policy = data.template_file.grafana_assume_role.rendered

#   tags = var.grafana_tags
# }

# resource "aws_iam_role" "grafana_logging" {
#   provider           = aws.logging
#   name               = local.service_name
#   assume_role_policy = data.template_file.grafana_assume_role.rendered

#   tags = var.grafana_tags
# }

# resource "aws_iam_role" "grafana_network" {
#   provider           = aws.network
#   name               = local.service_name
#   assume_role_policy = data.template_file.grafana_assume_role.rendered

#   tags = var.grafana_tags
# }

# resource "aws_iam_role_policy_attachment" "grafana_shared" {
#   provider   = aws.shared
#   role       = aws_iam_role.grafana_shared.id
#   policy_arn = data.aws_iam_policy.cloudwatch_readonly_access.arn
# }

# resource "aws_iam_role_policy_attachment" "grafana_logging" {
#   provider   = aws.logging
#   role       = aws_iam_role.grafana_logging.id
#   policy_arn = data.aws_iam_policy.cloudwatch_readonly_access.arn
# }

# resource "aws_iam_role_policy_attachment" "grafana_network" {
#   provider   = aws.network
#   role       = aws_iam_role.grafana_network.id
#   policy_arn = data.aws_iam_policy.cloudwatch_readonly_access.arn
# }

# resource "aws_iam_policy" "grafana_cross_accounts" {
#   name   = local.service_name
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "AllowStsSwanAccounts",
#       "Effect": "Allow",
#       "Action": "sts:AssumeRole",
#       "Resource": [
#         "${aws_iam_role.grafana_shared.arn}",
#         "${aws_iam_role.grafana_logging.arn}",
#         "${aws_iam_role.grafana_network.arn}"
#       ]
#     }
#   ]
# }
# EOF
# }
