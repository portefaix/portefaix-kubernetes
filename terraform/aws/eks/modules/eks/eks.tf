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

  vpc_id  = data.aws_vpc.main.id
  subnets = data.aws_subnet_ids.private.ids

  cluster_tags = merge(var.cluster_tags, var.tags)
  tags         = var.tags

  cluster_endpoint_private_access = true
  enable_irsa                     = true
  openid_connect_audiences        = ["sts.amazonaws.com"]
  manage_aws_auth                 = false

  workers_additional_policies = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]

  node_groups_defaults = var.node_groups_defaults
  node_groups          = var.node_groups

  cluster_enabled_log_types     = var.enabled_logs
  cluster_log_retention_in_days = var.log_retention
  write_kubeconfig              = false

  map_roles = var.map_roles
}
