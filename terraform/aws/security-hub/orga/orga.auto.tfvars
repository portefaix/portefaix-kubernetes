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

region = "eu-west-1"

#############################################################################
# Project

org_name = "portefaix"

audit_account_id = "752792911180"

##############################################################################
# Security Hub

service_name = "portefaix-security"

members = {
  "root"     = "634920727396",
  "security" = "371852329506",
  # "audit" = "752792911180",
  "logging"      = "763212660804",
  "testing"      = "352313078292"
  "network"      = "959847717158",
  "shared"       = "306755981912",
  "core-prod"    = "571624819032",
  "core-staging" = "845676325565",
  "core-dev"     = "755741063834",
}

enable_aws_foundational = true
enable_cis              = true
enable_pci_dss          = true

tags = {
  "Service" = "Security Hub"
}
