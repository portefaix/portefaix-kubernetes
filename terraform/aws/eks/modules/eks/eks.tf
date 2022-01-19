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

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.2.1"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = data.aws_vpc.main.id
  subnet_ids = data.aws_subnet_ids.private.ids

  cluster_tags = merge(var.cluster_tags, var.tags)
  tags         = var.tags

  cluster_endpoint_private_access = true
  enable_irsa                     = true
  openid_connect_audiences        = ["sts.amazonaws.com"]

  # Self Managed Node Group(s)
  self_managed_node_group_defaults = merge(
    var.self_managed_node_group_defaults,
    {
      vpc_security_group_ids       = [aws_security_group.additional.id]
      iam_role_additional_policies = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
    }
  )
  self_managed_node_groups = var.self_managed_node_groups

  eks_managed_node_group_defaults = merge(
    var.eks_managed_node_group_defaults,
    { vpc_security_group_ids = [aws_security_group.additional.id] }
  )
  eks_managed_node_groups = var.eks_managed_node_groups

  fargate_profile_defaults = var.fargate_profile_defaults
  fargate_profiles         = var.fargate_profiles


  cluster_addons = var.cluster_addons
}
