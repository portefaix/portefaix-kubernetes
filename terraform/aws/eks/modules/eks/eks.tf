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

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.28.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = data.aws_vpc.main.id
  subnet_ids = data.aws_subnets.private.ids

  cluster_tags = merge(var.cluster_tags, var.tags)
  tags         = var.tags

  cluster_endpoint_private_access = true
  enable_irsa                     = true
  openid_connect_audiences        = ["sts.amazonaws.com"]

  # cluster_security_group_additional_rules = {
  #   egress_nodes_ephemeral_ports_tcp = {
  #     description                = "To node 1025-65535"
  #     protocol                   = "tcp"
  #     from_port                  = 1025
  #     to_port                    = 65535
  #     type                       = "egress"
  #     source_node_security_group = true
  #   }
  # }

  node_security_group_additional_rules = {
    # Control plane invoke Karpenter webhook
    ingress_karpenter_webhook_tcp = {
      description                   = "Control plane invoke Karpenter webhook"
      protocol                      = "tcp"
      from_port                     = 8443
      to_port                       = 8443
      type                          = "ingress"
      source_cluster_security_group = true
    }
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

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
