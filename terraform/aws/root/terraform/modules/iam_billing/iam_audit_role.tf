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

data "aws_iam_policy_document" "billing_policy" {
  statement {
    sid = "AllowView"

    actions = [
      "aws-portal:ViewAccount",
      "aws-portal:ViewBilling",
      "aws-portal:ViewBudget",
      "aws-portal:ViewPaymentMethods",
      "aws-portal:ViewUsage",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid    = "DenyModify"
    effect = "Deny"

    actions = [
      "aws-portal:Modify*",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "billing_rights" {
  name   = format("%s%s", title(var.org_name), local.service_name)
  policy = data.aws_iam_policy_document.billing_policy.json
}
