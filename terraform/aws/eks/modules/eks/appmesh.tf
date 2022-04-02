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

resource "aws_iam_policy" "appmesh_controller" {
  name        = var.appmesh_controller_role_policy_name
  description = format("Allow AppMesh Controller to manage AWS AppMesh resources")
  path        = "/"
  #tfsec:ignore:AWS099
  policy = file("${path.module}/appmesh_policy.json")
  tags = merge(
    var.cluster_tags,
    var.ebs_csi_driver_tags,
    var.tags
  )
}

module "appmesh_controller_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.18.0"

  create_role                   = true
  role_description              = "AppMesh Role"
  role_name                     = var.appmesh_controller_role_name
  provider_url                  = module.eks.cluster_oidc_issuer_url
  role_policy_arns              = [aws_iam_policy.appmesh_controller.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.appmesh_namespace}:${var.appmesh_sa_name}"]
  tags = merge(
    var.cluster_tags,
    var.appmesh_tags,
    var.tags
  )
}
