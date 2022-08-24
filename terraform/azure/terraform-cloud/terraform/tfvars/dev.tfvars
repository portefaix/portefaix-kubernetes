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

############################################################################
# Provider


############################################################################
# Terraform Cloud

organization = "portefaix"

workspace_environment = "dev"

workspaces = {
  portefaix-azure-dev-vnet = {
    directory      = "terraform/azure/vnet/dev"
    tags           = ["azure", "vnet"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/vnet/*.tf",
    ]
  },
  portefaix-azure-dev-hub = {
    directory      = "terraform/azure/hub/dev"
    tags           = ["azure", "hub"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/hub/*.tf",
    ]
  },
  portefaix-azure-dev-public-ips-nat-gateway = {
    directory      = "terraform/azure/public-ips/nat-gateway/dev"
    tags           = ["azure", "publicip", "natgateway"]
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
  portefaix-azure-dev-nat-gateway = {
    directory      = "terraform/azure/nat-gateway/dev"
    tags           = ["azure", "natgateway"]
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
  portefaix-azure-dev-application-gateway = {
    directory      = "terraform/azure/application-gateway/dev"
    tags           = ["azure", "applicationgateway"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/application-gateway/*.tf",
    ]
  },
  portefaix-azure-dev-aks = {
    directory      = "terraform/azure/aks/dev"
    tags           = ["azure", "aks"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/aks/*.tf",
    ]
  },
  portefaix-azure-dev-secrets = {
    directory      = "terraform/azure/secrets/dev"
    tags           = ["azure", "secrets"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/secrets/*.tf",
    ]
  },
  portefaix-azure-dev-observability = {
    directory      = "terraform/azure/observability/dev"
    tags           = ["azure", "kubernetes", "observability"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/observability/*.tf",
    ]
  },
  portefaix-azure-dev-velero = {
    directory      = "terraform/azure/velero/dev"
    tags           = ["azure", "kubernetes", "velero"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/velero/*.tf",
    ]
  },
  portefaix-azure-dev-bastion = {
    directory      = "terraform/azure/bastion/dev"
    tags           = ["azure", "bastion"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/bastion/*.tf",
    ]
  },
  portefaix-azure-dev-peering = {
    directory      = "terraform/azure/peering/dev"
    tags           = ["azure", "peering"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/peering/*.tf",
    ]
  },
  portefaix-azure-dev-firewall = {
    directory      = "terraform/azure/firewall/dev"
    tags           = ["azure", "firewall"]
    gitops         = false
    branch         = "master"
    auto_apply     = true
    execution_mode = "remote"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/firewall/*.tf",
    ]
  },

}

gh_organization = "portefaix"
gh_repo         = "portefaix"
