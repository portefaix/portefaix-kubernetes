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

# data "aws_iam_policy_document" "logging_account_policy" {

#   statement {
#     sid    = "AllowS3"
#     effect = "Allow"
#     actions = [
#       "s3:*"
#     ]
#     resources = [
#       join("", ["arn:aws:s3:::", <logging_acc_s3_bucket_name>, "*"]),
#       join("", ["arn:aws:s3:::", <logging_acc_s3_bucket_name>, "*/*"])
#     ]
#   }
#   statement {
#     sid    = "AllowKMS"
#     effect = "Allow"
#     actions = [
#       "kms:ListGrants",
#       "kms:DescribeKey",
#       "kms:GetKeyPolicy",
#       "kms:ListKeys",
#       "kms:ListResourceTags",
#       "kms:GetKeyRotationStatus",
#       "kms:PutKeyPolicy",
#       "kms:ScheduleKeyDeletion",
#       "kms:GenerateDataKey",
#       "kms:CreateKey",
#       "kms:EnableKeyRotation",
#       "kms:CreateAlias",
#       "kms:ListAliases",
#       "kms:DeleteAlias"
#     ]
#     resources = [
#       "*"
#     ]
#     condition {
#       test = "StringEquals"
#       variable = "kms:CallerAccount"
#       values = [var.logging_account_id]
#     }
#   }
#   statement {
#     sid = "AllowIamPerms"
#     effect = "Allow"
#     actions = ["iam:GetRole"]
#     resources = ["arn:aws:iam::*:role/aws-service-role/*guardduty.amazonaws.com/*"]
#   }
#   statement {
#     sid = "AllowSvcLinkedRolePerms"
#     actions = ["iam:CreateServiceLinkedRole"]
#     resources = ["arn:aws:iam::*:role/aws-service-role/*guardduty.amazonaws.com/*"]
#     condition {
#       test = "StringLike"
#       variable = "iam:AWSServiceName"
#       values = ["guardduty.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_policy" "logging_account" {
#   name   = "gd_terraform_logging_acct_policy"
#   policy = data.aws_iam_policy_document.logging_acct_pol.json
# }

# resource "aws_iam_role_policy_attachment" "logging_account" {
#   role       = aws_iam_role.assume_root.name
#   policy_arn = aws_iam_policy.logging_account.arn
# }
