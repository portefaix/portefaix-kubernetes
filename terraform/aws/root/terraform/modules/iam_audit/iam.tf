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

##################################################################
## Audit

data "aws_iam_policy_document" "assume_root" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [format("arn:aws:iam::%s:root", data.aws_caller_identity.this.account_id)]
    }
  }
}

resource "aws_iam_role" "audit" {
  name               = format("%s%s", title(var.org_name), title(var.audit_role_name))
  assume_role_policy = data.aws_iam_policy_document.assume_root.json

  tags = merge({
    "Name" = format("%s%s", title(var.org_name), title(var.audit_role_name)),
    },
    var.tags
  )
}

resource "aws_iam_policy" "audit" {
  name   = format("%s%s%s", title(var.org_name), local.service_name, title(var.account))
  path   = "/"
  policy = data.aws_iam_policy_document.audit_policy.json

  tags = merge({
    "Name" = format("%s%s%s", title(var.org_name), local.service_name, title(var.account)),
    },
  var.tags)
}

resource "aws_iam_role_policy_attachment" "audit" {
  role       = aws_iam_role.audit.name
  policy_arn = aws_iam_policy.audit.arn
}
