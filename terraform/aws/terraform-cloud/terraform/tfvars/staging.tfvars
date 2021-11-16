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

##############################################################################
# Terraform Cloud

organization = "portefaix"

workspaces = {
  portefaix-aws-staging-vpc = {
    directory = "terraform/aws/vpc/staging"
    branch    = "feat/tfcloud-aws-vpc"
    tags      = ["aws", "vpc"]
  },
  portefaix-aws-staging-eip-igw = {
    directory = "terraform/aws/elastic-ips/internet-gateway/staging"
    branch    = "feat/tfcloud-aws-vpc"
    tags      = ["aws", "elasticip", "internetgateway"]
  },
  portefaix-aws-staging-eks = {
    directory = "terraform/aws/eks/staging"
    branch    = "feat/tfcloud-aws-vpc"
    tags      = ["aws", "eks"]
  },
  portefaix-aws-staging-observability = {
    directory = "terraform/aws/observability/staging"
    branch    = "feat/tfcloud-aws-vpc"
    tags      = ["aws", "stack", "observability"]
  },
  portefaix-aws-staging-cert-manager = {
    directory = "terraform/aws/cert-manager/staging"
    branch    = "feat/tfcloud-aws-vpc"
    tags      = ["aws", "stack", "observability"]
  },
  portefaix-aws-staging-external-dns = {
    directory = "terraform/aws/external-dns/staging"
    branch    = "feat/tfcloud-aws-vpc"
    tags      = ["aws", "stack", "externaldns"]
  },
  portefaix-aws-staging-velero = {
    directory = "terraform/aws/velero/staging"
    branch    = "feat/tfcloud-aws-vpc"
    tags      = ["aws", "stack", "velero"]
  },
  portefaix-aws-staging-vector = {
    directory = "terraform/aws/vector/staging"
    branch    = "feat/tfcloud-aws-vpc"
    tags      = ["aws", "stack", "vector"]
  }
}

gh_organization = "portefaix"
gh_repo         = "portefaix"
