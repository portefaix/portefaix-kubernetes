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

region = "eu-west-1"

#############################################################################
# VPC

vpc_name = "portefaix-staging"

vpc_subnet_cidr     = "10.0.0.0/16"
public_subnet_cidr  = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]
private_subnet_cidr = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]

enable_nat_gateway = true

vpc_tags = {
  "Name"              = "portefaix-staging"
  "Env"               = "staging"
  "Service"           = "vpc"
  "Portefaix-Version" = "v0.28.0"
}

public_subnet_tags = {
  "Name"              = "portefaix-staging-public"
  "Env"               = "staging"
  "service"           = "public-subnet"
  "Portefaix-Version" = "v0.28.0"
}

private_subnet_tags = {
  "Name"              = "portefaix-staging-private"
  "Env"               = "staging"
  "Service"           = "private-subnet"
  "Portefaix-Version" = "v0.28.0"
}

vpc_flow_log_tags = {
  "Name"              = "portefaix-staging"
  "Env"               = "staging"
  "Service"           = "vpc"
  "Portefaix-Version" = "v0.28.0"
}

igw_tags = {
  "Name"              = "portefaix-staging"
  "Env"               = "staging"
  "Service"           = "internet gateway"
  "Portefaix-Version" = "v0.28.0"
}

eks_cluster_name = "portefaix-staging-eks"
