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

locals {
  shared_account  = "shared"
  audit_account   = "audit"
  logging_account = "logging"
  # security_account     = "security"
  network_account      = "network"
  testing_account      = "testing"
  core_prod_account    = "core-prod"
  core_staging_account = "core-staging"
  core_dev_account     = "core-dev"

  budget_admin_email    = "${var.org_email}+${var.org_admin_username}@${var.org_email}"
  sns_budget_topic_name = format("%s-budgets", var.org_name)

  org_accounts = [
    aws_organizations_account.shared,
    aws_organizations_account.audit,
    aws_organizations_account.logging,
    # aws_organizations_account.security,
    aws_organizations_account.network,
    aws_organizations_account.testing,
    aws_organizations_account.core_prod,
    aws_organizations_account.core_staging,
    aws_organizations_account.core_dev
  ]

  sns_security_alerts = format("%s-%s", var.org_name, var.sns_security_alerts)
}
