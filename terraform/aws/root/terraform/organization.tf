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

resource "aws_organizations_organization" "this" {
  enabled_policy_types          = var.enabled_policy_types
  aws_service_access_principals = var.aws_service_access_principals
  feature_set                   = "ALL"
}

resource "aws_servicecatalog_organizations_access" "this" {
  enabled = "true"
}

resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = aws_organizations_organization.this.roots[0].id

  tags = merge({
    "Name"    = "Security"
    "Service" = "Organization"
  }, var.tags)
}

resource "aws_organizations_organizational_unit" "shared" {
  name      = "Shared"
  parent_id = aws_organizations_organization.this.roots[0].id

  tags = merge({
    "Name"    = "Shared"
    "Service" = "Organization"
  }, var.tags)
}

resource "aws_organizations_organizational_unit" "core" {
  name      = "Core"
  parent_id = aws_organizations_organization.this.roots[0].id

  tags = merge({
    "Name"    = "Core"
    "Service" = "Organization"
  }, var.tags)
}

resource "aws_organizations_organizational_unit" "suspended" {
  name      = "Suspended"
  parent_id = aws_organizations_organization.this.roots[0].id

  tags = merge({
    "Name"    = "Suspended"
    "Service" = "Organization"
  }, var.tags)
}
