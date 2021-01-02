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

region = "eu-central-1"

#############################################################################
# VPC

vpc_name     = "portefaix-dev"
vswitch_name = "portefaix-dev"

vpc_subnet_cidr = "10.0.0.0/16"
vswitch_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]

availability_zones = ["eu-central-a", "eu-central-b"]

vpc_tags = {
    "Name"    = "portefaix-dev"
    "project" = "portefaix"
    "env"     = "dev"
    "service" = "vpc"
    "made-by" = "terraform"
}

vswitch_tags = {
    "Name"    = "portefaix-dev"
    "project" = "portefaix"
    "env"     = "dev"
    "service" = "internet-gateway"
    "made-by" = "terraform"
}
