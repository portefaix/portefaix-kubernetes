# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_secretsmanager_secret_version.oidc_url.secret_binary, "https://", "")}:sub"
      values   = [format("system:serviceaccount:%s:%s", var.namespace, var.service_account)]
    }

    principals {
      identifiers = [data.aws_secretsmanager_secret_version.oidc_arn.secret_binary]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "external_dns" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  name               = var.service_name
  tags               = var.tags
}

data "aws_iam_policy_document" "external_dns_permissions" {
  statement {
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets",
    ]

    resources = [
      "arn:aws:route53:::hostedzone/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "external_dns_permissions" {
  name        = var.service_name
  path        = "/"
  description = "Permissions for External-DNS on Route53"
  policy      = data.aws_iam_policy_document.external_dns_permissions.json
}

resource "aws_iam_role_policy_attachment" "external_dns" {
  role       = aws_iam_role.external_dns.name
  policy_arn = aws_iam_policy.external_dns_permissions.arn
}


