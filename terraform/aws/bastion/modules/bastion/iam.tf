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

module "ec2_ssm" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.5.5"

  role_name               = var.ec2_ssm_role_name
  create_instance_profile = true
  create_role             = true
  custom_role_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  role_requires_mfa       = false
  trusted_role_services   = ["ec2.amazonaws.com"]
  tags                    = var.ec2_ssm_tags
}

# resource "aws_iam_role" "ec2_ssm_role" {
#   name = "aws-role-ec2ssm"
#   path = "/"

#   assume_role_policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Action": "sts:AssumeRole",
#             "Principal": {
#                "Service": "ec2.amazonaws.com"
#             },
#             "Effect": "Allow",
#             "Sid": ""
#         }
#     ]
# }
# EOF
# }

# resource "aws_iam_instance_profile" "ec2_ssm_profile" {
#   name = "aws-role-ec2ssm"
#   role = aws_iam_role.ec2_ssm_role.name
# }

# resource "aws_iam_role_policy_attachment" "ec2_ssm_profile" {
#   role       = aws_iam_role.ec2_ssm_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
# }
