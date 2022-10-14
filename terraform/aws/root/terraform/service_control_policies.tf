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

resource "aws_organizations_policy" "deny_aws_account_root_user" {
  name        = format("%sDenyAWSAccountRootUser", title(var.org_name))
  description = "Denies the ability to use the AWS account root user (https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html)"
  type        = "SERVICE_CONTROL_POLICY"

  content = data.aws_iam_policy_document.deny_aws_account_root_user.json

  tags = merge({
    "Name"    = format("%sDenyAWSAccountRootUser", title(var.org_name))
    "Service" = "Policies"
  }, var.tags)
}

data "aws_iam_policy_document" "deny_aws_account_root_user" {
  # Deny AWS account root user actions
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalArn"
      values   = ["arn:aws:iam::*:root"]
    }
  }
}

# resource "aws_organizations_policy" "deny_disabling_cloudtrail" {
#   name        = format("%sDenyDisablingCloudtrail", title(var.org_name))
#   description = "Deny disabling Cloudtrail"

#   content = <<CONTENT
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Deny",
#       "Action": [
#         "cloudtrail:StopLogging",
#         "cloudtrail:DeleteTrail",
#         "cloudtrail:UpdateTrail"
#       ],
#       "Resource": "arn:*:cloudtrail:*:*:trail/swan"
#     }
#   ]
# }
# CONTENT

#   tags = merge({
#     "Name"    = format("%sDenyDisablingCloudtrail", title(var.org_name))
#     "Service" = "Policies"
#   }, var.tags)
# }

resource "aws_organizations_policy" "deny_leaving_organization" {
  name        = format("%sDenyLeavingOrganization", title(var.org_name))
  description = "Deny leaving organization"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "organizations:LeaveOrganization",
      "Resource": "*"
    }
  ]
}
CONTENT

  tags = merge({
    "Name"    = format("%sDenyLeavingOrganization", title(var.org_name))
    "Service" = "Policies"
  }, var.tags)
}
