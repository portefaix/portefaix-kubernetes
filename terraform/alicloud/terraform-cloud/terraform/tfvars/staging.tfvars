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

#############################################################################
# Provider



##############################################################################
# Terraform Cloud

organization = "portefaix"

workspaces = {
  portefaix-alicloud-staging-vpc = {
    directory      = "terraform/alicloud/vpc/staging"
    tags           = ["alicloud", "vpc"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/vpc/*.tf",
    ]
  },
  portefaix-alicloud-staging-key-pair = {
    directory      = "terraform/alicloud/key-pair/staging"
    tags           = ["alicloud", "ssh", "keypair"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/key-pair/*.tf",
    ]
  },
  portefaix-alicloud-staging-eip-nat-gateway = {
    directory      = "terraform/alicloud/elastic-ips/nat-gateway/staging"
    tags           = ["alicloud", "elasticip", "natgateway"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/nat-gateway/*.tf",
    ]
  },
  portefaix-alicloud-staging-nat-gateway = {
    directory      = "terraform/alicloud/nat-gateway/staging"
    tags           = ["alicloud", "natgateway"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/nat-gateway/*.tf",
    ]
  },
  portefaix-alicloud-staging-ack = {
    directory      = "terraform/alicloud/ack/staging"
    tags           = ["alicloud", "ack"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/ack/*.tf",
    ]
  },
}

gh_organization = "portefaix"
gh_repo         = "portefaix"
