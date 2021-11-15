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

locals {
  production = {
    vpc_name = "portefaix-production"

    vpc_subnet_cidr     = "10.10.0.0/16"
    public_subnet_cidr  = ["10.10.128.0/20", "10.10.144.0/20", "10.10.160.0/20"]
    private_subnet_cidr = ["10.10.0.0/19", "10.10.32.0/19", "10.10.64.0/19"]

    enable_nat_gateway = true
    vpc_tags = {
      "Name"    = "portefaix-production"
      "Env"     = "production"
      "Service" = "vpc"
    }

    public_subnet_tags = {
      "Name"    = "portefaix-production-public"
      "Env"     = "production"
      "service" = "public-subnet"
    }

    private_subnet_tags = {
      "Name"    = "portefaix-production-private"
      "Env"     = "production"
      "Service" = "private-subnet"
    }

    igw_tags = {
      "Name"    = "Internet Gateway"
      "Env"     = "production"
      "Service" = "internet gateway"
    }

    eks_cluster_name = "portefaix-production-eks"
  }
}
