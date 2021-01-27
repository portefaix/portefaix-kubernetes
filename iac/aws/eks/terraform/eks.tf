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

module "eks" {
  source  = "nlamirault/eks/aws"
  version = "0.7.0"
  
  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version

  vpc_id              = var.vpc_id
  public_subnet_tags  = var.public_subnet_tags
  private_subnet_tags = var.private_subnet_tags

  desired_size = var.desired_size
  min_size     = var.min_size
  max_size     = var.max_size

  capacity_type      = var.capacity_type
  disk_size          = var.disk_size
  node_instance_type = var.node_instance_type

  eks_logging = var.eks_logging

  tags = var.tags

  node_pools = var.node_pools

  recovery_window_in_days = var.recovery_window_in_days
}
