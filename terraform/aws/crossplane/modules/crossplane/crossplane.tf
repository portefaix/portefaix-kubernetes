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

data "aws_iam_policy_document" "this" {

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringLike"
      variable = "${replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:sub"
      values = [
        "system:serviceaccount:${var.namespace}:${var.service_account}"
      ]
    }

    principals {
      identifiers = [data.aws_eks_cluster.this.identity[0].oidc[0].issuer]
      type        = "Federated"
    }
  }
}


resource "aws_iam_policy" "this" {
  name_prefix = var.role_policy_name
  description = "Crossplane policy"
  policy      = data.aws_iam_policy_document.this.json
}

module "crossplane_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.14.0"

  create_role                   = true
  role_description              = "Crossplane"
  role_name                     = var.role_name
  provider_url                  = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
  role_policy_arns              = [aws_iam_policy.this.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
  tags                          = var.tags
}
