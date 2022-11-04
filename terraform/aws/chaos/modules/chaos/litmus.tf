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

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "litmus" {
  statement {
    sid    = "AllowLitmusChaosEC2"
    effect = "Allow"
    actions = [
      "ec2:*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "litmus" {
  name        = local.litmus_service_name
  path        = "/"
  description = "Permissions for LitmusChaos"
  policy      = data.aws_iam_policy_document.litmus.json
  tags = merge(
    { "Name" = local.litmus_service_name },
    local.tags
  )
}

module "irsa_litmuschaos" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.5.5"

  create_role                   = true
  role_description              = "Role for LitmusChaos"
  role_name                     = local.role_name
  provider_url                  = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
  role_policy_arns              = aws_iam_policy.litmus.arn
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
  tags = merge(
    {
      "Name" = local.role_name,
      "Iam"  = "eks-litmuschaos"
    },
    local.tags
  )
}
