# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

data "aws_iam_policy_document" "ebs_controller_policy_doc" {
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "ec2:AttachVolume",
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:DeleteSnapshot",
      "ec2:DeleteTags",
      "ec2:DeleteVolume",
      "ec2:DescribeInstances",
      "ec2:DescribeSnapshots",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DetachVolume",
      "ec2:ModifyVolume",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeVolumesModifications"
    ]
  }
}

resource "aws_iam_policy" "ebs_controller_policy" {
  name_prefix = var.ebs_csi_controller_role_policy_name_prefix
  policy      = data.aws_iam_policy_document.ebs_controller_policy_doc.json
  tags        = merge(var.ebs_csi_tags, var.tags)
}

module "ebs_controller_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.7.0"

  create_role                   = true
  role_description              = "EBS CSI Driver Role"
  role_name_prefix              = var.ebs_csi_controller_role_name
  provider_url                  = module.eks.cluster_oidc_issuer_url
  role_policy_arns              = [aws_iam_policy.ebs_controller_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.ebs_csi_controller_namespace}:${var.ebs_csi_controller_sa_name}"]
  tags                          = merge(var.ebs_csi_tags, var.tags)
}