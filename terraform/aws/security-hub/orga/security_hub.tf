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

module "security_hub" {
  source = "../modules/security-hub"

  providers = {
    aws       = aws
    aws.audit = aws.audit
  }

  org_name         = var.org_name
  org_email        = var.org_email
  org_email_domain = var.org_email_domain

  audit_account_id = var.audit_account_id

  members = var.members

  service_name = var.service_name

  enable_aws_foundational = var.enable_aws_foundational
  enable_cis              = var.enable_cis
  enable_pci_dss          = var.enable_pci_dss

  tags = var.tags
}
