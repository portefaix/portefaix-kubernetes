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

module "irsa_eso" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.5.5"

  role_name                      = var.eso_role_name
  attach_external_secrets_policy = true

  oidc_providers = {
    main = {
      provider_arn = module.eks.oidc_provider_arn
      namespace_service_accounts = [
        "${var.eso_namespace}:${var.eso_sa_name}",
      ]
    }
  }

  external_secrets_secrets_manager_arns = var.eso_secrets_arns

  tags = merge(
    { "Name" = var.eso_role_name },
    var.cluster_tags,
    var.eso_tags,
    var.tags
  )
}
