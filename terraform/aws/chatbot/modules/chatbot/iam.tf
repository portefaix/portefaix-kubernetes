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

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["chatbot.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = merge({
    Name = local.role_name
  }, var.tags)
}

resource "aws_iam_role_policy" "notifications" {
  count = var.allow_notifications ? 1 : 0

  name   = format("%s_NotificationsOnly", local.role_policy_name)
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.notifications[0].json
}

data "aws_iam_policy_document" "notifications" {
  count = var.allow_notifications ? 1 : 0

  #tfsec:ignore:aws-iam-no-policy-wildcards
  statement {
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "lambda_invoke" {
  count = var.allow_labmda_invoke ? 1 : 0

  name   = format("%s_LambdaInvoke", local.role_policy_name)
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.lambda_invoke[0].json
}

data "aws_iam_policy_document" "lambda_invoke" {
  count = var.allow_labmda_invoke ? 1 : 0

  statement {
    actions = [
      "lambda:invokeAsync",
      "lambda:invokeFunction",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "support_access" {
  count = var.allow_support_access ? 1 : 0

  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AWSSupportAccess"
}

resource "aws_iam_role_policy_attachment" "read_only_access" {
  count = var.allow_read_only_access ? 1 : 0

  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
