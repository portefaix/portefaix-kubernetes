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

#############################################################################
# Provider

region = "eu-west-3"

#############################################################################
# Networking

vpc_id = "vpc-0a6aa79113dcab039"

public_subnet_tags = {
    "project" = "portefaix"
    "env"     = "staging"
    "service" = "public-subnet"
    "made-by" = "terraform"
}

private_subnet_tags = {
    "project" = "portefaix"
    "env"     = "staging"
    "service" = "private-subnet"
    "made-by" = "terraform"
}

#############################################################################
# Kubernetes cluster

cluster_name = "portefaix-staging-eks"

kubernetes_version = "1.18"

desired_size = 2
min_size = 1
max_size = 3

capacity_type = "SPOT"

disk_size = 20

node_instance_type = "t3.large"

tags = {
    "project" = "portefaix"
    "env"     = "staging"
    "service" = "kubernetes"
    "made-by" = "terraform"
}

#############################################################################
# Addons node pool

node_pools = {}
#node_pools = {
#    "ops" = {
#        desired_size = 1
#        min_size = 1
#        max_size = 1
#        capacity_type = "SPOT"
#        disk_size = 20
#        node_instance_type = "t3.large"
#    },
#}

#############################################################################
# Secret Manager

recovery_window_in_days = 0