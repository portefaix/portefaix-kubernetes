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

############################################################################
# Provider


############################################################################
# Terraform Cloud

organization = "portefaix"

workspaces = {
  portefaix-azure-dev-vnet = {
    directory = "terraform/azure/vnet/dev"
    branch    = "feat/tfcloud-azure"
    tags      = ["azure", "vnet"]
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/vnet/*.tf",
    ]
  },
  portefaix-azure-dev-public-ips-nat-gateway = {
    directory = "terraform/public-ips/nat-gateway/dev"
    branch    = "feat/tfcloud-azure"
    tags      = ["azure", "publicip", "natgateway"]
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/nat-gateway/*.tf",
    ]
  },
  portefaix-azure-dev-nat-gateway = {
    directory = "terraform/nat-gateway/dev"
    branch    = "feat/tfcloud-azure"
    tags      = ["azure", "natgateway"]
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/nat-gateway/*.tf",
    ]
  },
  portefaix-azure-dev-aks = {
    directory = "terraform/aks/dev"
    branch    = "feat/tfcloud-azure"
    tags      = ["azure", "aks"]
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/aks/*.tf",
    ]
  },
  portefaix-azure-dev-observability = {
    directory = "terraform/observability/dev"
    branch    = "feat/tfcloud-azure"
    tags      = ["azure", "kubernetes", "observability"]
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/observability/*.tf",
    ]
  },
  portefaix-azure-dev-velero = {
    directory = "terraform/velero/dev"
    branch    = "feat/tfcloud-azure"
    tags      = ["azure", "kubernetes", "velero"]
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/velero/*.tf",
    ]
  },

}

gh_organization = "portefaix"
gh_repo         = "portefaix"
