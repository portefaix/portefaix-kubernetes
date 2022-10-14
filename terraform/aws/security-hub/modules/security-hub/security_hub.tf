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

resource "aws_securityhub_account" "this" {}

resource "aws_securityhub_organization_admin_account" "audit_account" {
  admin_account_id = var.audit_account_id
}

resource "aws_securityhub_organization_configuration" "this" {
  provider    = aws.audit
  auto_enable = true

  depends_on = [
    aws_securityhub_organization_admin_account.audit_account
  ]
}

resource "aws_securityhub_member" "accounts" {
  for_each = var.members

  provider = aws.audit

  account_id = each.value
  email      = "${var.org_email}+${var.org_name}.${each.key}@${var.org_email_domain}"
  invite     = false
}

# Enable Standard: AWS Foundational Security Best Practices
resource "aws_securityhub_standards_subscription" "aws_foundational" {
  provider      = aws.audit
  count         = var.enable_aws_foundational ? 1 : 0
  standards_arn = "arn:aws:securityhub:${data.aws_region.this.name}::standards/aws-foundational-security-best-practices/v/1.0.0"

  depends_on = [
    aws_securityhub_account.this,
    aws_securityhub_member.accounts
  ]
}

# Enable Standard: CIS AWS Foundations
resource "aws_securityhub_standards_subscription" "cis" {
  provider      = aws.audit
  count         = var.enable_cis ? 1 : 0
  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"

  depends_on = [
    aws_securityhub_account.this,
    aws_securityhub_member.accounts
  ]
}

# Enable Standard: PCI DSS v3.2.1
resource "aws_securityhub_standards_subscription" "pci_dss" {
  provider      = aws.audit
  count         = var.enable_pci_dss ? 1 : 0
  standards_arn = "arn:aws:securityhub:${data.aws_region.this.name}::standards/pci-dss/v/3.2.1"

  depends_on = [
    aws_securityhub_account.this,
    aws_securityhub_member.accounts
  ]
}
