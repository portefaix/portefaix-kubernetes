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
# VPC

vpc_name = "portefaix-staging"

vpc_subnet_cidr     = "10.0.0.0/16"
public_subnet_cidr  = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]
private_subnet_cidr = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]

vpc_tags = {
    "project" = "portefaix"
    "env"     = "staging"
    "service" = "vpc"
    "made-by" = "terraform"
}

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

igw_tags = {
    "project" = "portefaix"
    "env"     = "staging"
    "service" = "internet-gateway"
    "made-by" = "terraform"
}

eks_cluster_name = "portefaix-staging-eks"