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

resource "aws_wafv2_ip_set" "whitelist" {
  name               = local.acl_whitelist_name
  description        = var.description
  scope              = var.scope
  ip_address_version = "IPV4"
  addresses          = var.whitelist_ipv4

  tags = merge({
    Name = local.acl_whitelist_name
  }, var.tags)
}

resource "aws_wafv2_ip_set" "blacklist" {
  name               = local.acl_blacklist_name
  description        = var.description
  scope              = var.scope
  ip_address_version = "IPV4"
  addresses          = var.blacklist_ipv4

  tags = merge({
    Name = local.acl_blacklist_name
  }, var.tags)
}

resource "aws_wafv2_web_acl" "this" {
  name        = local.acl_core_name
  description = var.description
  scope       = var.scope

  default_action {
    allow {}
  }

  dynamic "rule" {
    for_each = local.managed_rules

    content {
      name     = rule.value.name
      priority = rule.value.priority

      # override_action {
      #   dynamic "none" {
      #     for_each = rule.value.override_action == "none" ? [1] : []
      #     content {}
      #   }

      #   dynamic "count" {
      #     for_each = rule.value.override_action == "count" ? [1] : []
      #     content {}
      #   }
      # }

      statement {
        managed_rule_group_statement {
          name        = rule.value.name
          vendor_name = "AWS"

          dynamic "excluded_rule" {
            for_each = rule.value.excluded_rule
            content {
              name = excluded_rule.value
            }
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.name
        sampled_requests_enabled   = true
      }
    }
  }

  # dynamic "rule" {
  #   for_each = var.allowed_country_codes == [] ? [] : [1]
  #   content {
  #     name     = local.rule_whitelist_country_name
  #     priority = 2

  #     action {
  #       allow {}
  #     }

  #     statement {
  #       not_statement {
  #         statement {
  #           geo_match_statement {
  #             country_codes = var.allowed_country_codes
  #           }
  #         }
  #       }
  #     }

  #     visibility_config {
  #       cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
  #       metric_name                = local.rule_whitelist_country_name
  #       sampled_requests_enabled   = true
  #     }
  #   }
  # }

  # dynamic "rule" {
  #   for_each = var.whitelist_ipv4 == [] ? [] : [1]
  #   content {
  #     name     = local.rule_whitelist_ips
  #     priority = 1

  #     action {
  #       allow {}
  #     }

  #     statement {
  #       ip_set_reference_statement {
  #         arn = aws_wafv2_ip_set.whitelist.arn
  #       }
  #     }

  #     visibility_config {
  #       cloudwatch_metrics_enabled = true
  #       metric_name                = local.rule_whitelist_ips
  #       sampled_requests_enabled   = true
  #     }
  #   }
  # }

  # dynamic "rule" {
  #   for_each = var.whitelist_ipv4 == [] ? [] : [1]
  #   content {
  #     name     = local.rule_blacklist_ips
  #     priority = 3

  #     action {
  #       block {}
  #     }

  #     statement {
  #       ip_set_reference_statement {
  #         arn = aws_wafv2_ip_set.blacklist.arn
  #       }
  #     }

  #     visibility_config {
  #       cloudwatch_metrics_enabled = true
  #       metric_name                = local.rule_blacklist_ips
  #       sampled_requests_enabled   = true
  #     }
  #   }
  # }

  visibility_config {
    cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
    metric_name                = local.acl_core_name
    sampled_requests_enabled   = true
  }

  tags = merge({
    Name = local.acl_core_name
  }, var.tags)
}
