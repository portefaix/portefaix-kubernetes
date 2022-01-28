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

resource "aws_wafv2_web_acl" "core" {
  name        = local.acl_core_name
  description = var.description
  scope       = var.scope

  default_action {
    allow {}
  }

  dynamic "rule" {
    for_each = {
      0 = "AWS-AWSManagedRulesCommonRuleSet",
      1 = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
      2 = "AWS-AWSManagedRulesSQLiRuleSet"
      3 = "AWS-AWSManagedRulesUnixRuleSet"
      4 = "AWS-AWSManagedRulesLinuxRuleSet"
      5 = "AWS-AWSManagedRulesAmazonIpReputationList"
    }
    content {
      priority = rule.key
      name     = rule.value

      override_action {
        count {}
      }

      statement {
        managed_rule_group_statement {
          vendor_name = element(split("-", rule.value), 0)
          name        = element(split("-", rule.value), 1)
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = false
        metric_name                = rule.value
        sampled_requests_enabled   = true
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "eks-${local.cluster_name}"
    sampled_requests_enabled   = true
  }

  tags = merge({
    Name = local.acl_name
  }, var.tags)
}
