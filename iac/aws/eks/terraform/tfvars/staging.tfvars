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

#############################################################################
# Provider

region = "eu-west-3"

#############################################################################
# Networking

# vpc_id = "vpc-0a6aa79113dcab039"
vpc_name = "portefaix-staging"

#############################################################################
# Kubernetes cluster

cluster_name = "portefaix-staging-eks"

cluster_version = "1.21"
cluster_tags = {
  "project" = "portefaix"
  "env"     = "staging"
  "service" = "kubernetes"
  "made-by" = "terraform"
}

tags = {
  "project" = "portefaix"
  "env"     = "staging"
  "service" = "kubernetes"
  "made-by" = "terraform"
}

node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }

node_groups = {
  core = {
    desired_capacity = 1
    max_capacity     = 1
    min_capacity     = 1

    instance_types = ["t3.medium"]
    key_name = "core"
    name = "portefaix-staging-eks-core"
  }
  ops = {
    desired_capacity = 0
    max_capacity     = 1
    min_capacity     = 1

    instance_types = ["t3.medium"]
    capacity_type  = "SPOT"
    key_name = "ops"
    name = "portefaix-staging-eks-ops"
    k8s_labels = {
      Environment = "staging"
      Project     = "portefaix"
    }
    additional_tags = {
      NodePool = "ops"
    }
    taints = [
        {
          key    = "role"
          value  = "ops"
          effect = "PREFER_NO_SCHEDULE"
        }
      ]
  }
}

map_roles = []
map_users = []
