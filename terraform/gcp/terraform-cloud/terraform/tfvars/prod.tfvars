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

#####################################################################""
# Provider

project = "portefaix-prod"

region = "europe-west1"

#############################################################################
# Terraform Cloud

organization = "portefaix"

workspaces = {
  portefaix-gcp-prod-vpc = {
    directory = "terraform/gcp/vpc/prod"
    tags      = ["gcp", "vpc"]
    gitops    = false
    branch    = "master"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/vpc/*.tf",
    ]
  },
  portefaix-gcp-prod-cloud-dns = {
    directory = "terraform/gcp/cloud-dns/prod"
    tags      = ["gcp", "clouddns"]
    gitops    = false
    branch    = "master"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/cloud-dns/*.tf",
    ]
  },
  portefaix-gcp-prod-external-ip-cloud-nat = {
    directory = "terraform/gcp/external-ips/cloud-nat/prod"
    tags      = ["gcp", "externalips", "cloudnat"]
    gitops    = false
    branch    = "master"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/cloudnat/*.tf",
    ]
  },
  portefaix-gcp-prod-cloud-nat = {
    directory = "terraform/gcp/cloud-nat/prod"
    tags      = ["gcp", "cloudnat"]
    gitops    = false
    branch    = "master"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/cloudnat/*.tf",
    ]
  },
  portefaix-gcp-prod-bastion = {
    directory = "terraform/gcp/bastion/prod"
    tags      = ["gcp", "bastion"]
    gitops    = false
    branch    = "master"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/bastion/*.tf",
    ]
  },
  portefaix-gcp-prod-pubsub = {
    directory = "terraform/gcp/pubsub/prod"
    tags      = ["gcp", "pubsub"]
    gitops    = false
    branch    = "master"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/pubsub/*.tf",
    ]
  },
  portefaix-gcp-prod-gke = {
    directory = "terraform/gcp/gke/prod"
    tags      = ["gcp", "gke"]
    gitops    = false
    branch    = "master"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/gke/*.tf",
    ]
  },
  portefaix-gcp-prod-observability = {
    directory = "terraform/gcp/observability/prod"
    tags      = ["gcp", "kubernetes", "observability"]
    gitops    = false
    branch    = "master"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/observability/*.tf",
    ]
  },
  portefaix-gcp-prod-cert-manager = {
    directory = "terraform/gcp/cert-manager/prod"
    tags      = ["gcp", "kubernetes", "certmanager"]
    gitops    = false
    branch    = "master"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/cert-manager/*.tf",
    ]
  },
  portefaix-gcp-prod-external-dns = {
    directory = "terraform/gcp/external-dns/prod"
    tags      = ["gcp", "kubernetes", "externaldns"]
    gitops    = false
    branch    = "master"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/external-dns/*.tf",
    ]
  },
  portefaix-gcp-prod-vector = {
    directory = "terraform/gcp/vector/prod"
    tags      = ["gcp", "kubernetes", "vector"]
    gitops    = false
    branch    = "master"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/vector/*.tf",
    ]
  },
  portefaix-gcp-prod-velero = {
    directory = "terraform/gcp/velero/prod"
    tags      = ["gcp", "kubernetes", "velero"]
    gitops    = false
    branch    = "master"
    trigger = [
      "*.tf",
      "*.tfvars",
      "../modules/velero/*.tf",
    ]
  },
}

gh_organization = "portefaix"
gh_repo         = "portefaix"
