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

resource "aws_organizations_policy" "mandatory_tags" {
  name        = format("%s-mandatory-tags", var.org_name)
  description = "Mandatory tags."
  type        = "TAG_POLICY"

  tags = merge({
    "Name"    = format("%s-mandatory-tags", var.org_name)
    "Service" = "Policies"
  }, var.tags)

  content = <<CONTENT
{
  "tags": {
    "Made-By": {
      "tag_key": {
        "@@assign": "Made-By"
      }
    },
    "Env": {
      "tag_key": {
        "@@assign": "Env"
      },
      "tag_value": {
        "@@assign": [
          "Dev",
          "Staging",
          "Prod",
          "Common",
          "Root"
        ]
      }
    }
  }
}
CONTENT
}

resource "aws_organizations_policy_attachment" "mandatory_tags" {
  policy_id = aws_organizations_policy.mandatory_tags.id
  target_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_policy" "optional_tags" {
  name        = format("%s-optional-tags", var.org_name)
  description = "Optional tags."
  type        = "TAG_POLICY"

  tags = merge({
    "Name"    = format("%s-optional-tags", var.org_name)
    "Service" = "Policies"
  }, var.tags)

  content = <<CONTENT
{
  "tags": {
    "Service": {
      "tag_key": {
        "@@assign": "Service"
      }
    },
    "Role": {
      "tag_key": {
        "@@assign": "Role"
      }
    }
  }
}
CONTENT
}

resource "aws_organizations_policy_attachment" "optional_tags" {
  policy_id = aws_organizations_policy.optional_tags.id
  target_id = aws_organizations_organization.this.roots[0].id
}
