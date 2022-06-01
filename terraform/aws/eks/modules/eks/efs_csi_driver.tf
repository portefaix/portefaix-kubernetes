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

resource "aws_iam_policy" "efs_csi_driver_controller" {
  name        = var.efs_csi_controller_role_policy_name
  description = format("Allow CSI Driver to manage AWS EFS resources")
  path        = "/"
  #tfsec:ignore:AWS099
  policy = file("${path.module}/efs_csi_driver_policy.json")
  tags = merge(
    var.cluster_tags,
    var.efs_csi_driver_tags,
    var.tags
  )
}

module "efs_controller_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.1.0"

  create_role                   = true
  role_description              = "EFS CSI Driver Role"
  role_name                     = var.efs_csi_controller_role_name
  provider_url                  = module.eks.cluster_oidc_issuer_url
  role_policy_arns              = [aws_iam_policy.efs_csi_driver_controller.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.efs_csi_controller_namespace}:${var.efs_csi_controller_sa_name}"]
  tags = merge(
    var.cluster_tags,
    var.efs_csi_driver_tags,
    var.tags
  )
}
