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

data "aws_iam_policy_document" "assume_audit" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [
      format("arn:aws:iam::%s:role/%s", aws_organizations_account.audit.id, var.admin_role_name)
    ]
  }
}

resource "aws_iam_group_policy" "assume_audit" {
  name   = format("%sAssume%s", title(var.org_name), title(local.audit_account))
  group  = var.admin_group_name
  policy = data.aws_iam_policy_document.assume_audit.json
}

##################################################################
## Audit Assume

data "aws_iam_policy_document" "audit" {
  provider = aws.audit
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [format("arn:aws:iam::%s:root", data.aws_caller_identity.this.account_id)]
    }
  }
}

##################################################################
## Admin

resource "aws_iam_role" "audit" {
  provider           = aws.audit
  name               = var.admin_role_name
  assume_role_policy = data.aws_iam_policy_document.audit.json

  tags = merge({
    "Name"    = var.admin_role_name,
    "Service" = "IAM"
    },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "audit" {
  provider   = aws.audit
  role       = aws_iam_role.audit.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

##################################################################
## Audit

module "audit_audit" {
  source = "./modules/iam_audit"

  providers = {
    aws = aws.audit
  }

  org_name = var.org_name
  account  = local.core_dev_account

  tags = merge({
    "Service" = "IAM"
    },
  var.tags)
}
