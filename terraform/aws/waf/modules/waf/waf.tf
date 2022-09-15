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

resource "aws_wafv2_ip_set" "admin" {
  name               = local.ip_set_admin_name
  description        = var.description
  scope              = var.scope
  ip_address_version = "IPV4"
  addresses          = var.admin_ipv4

  tags = merge({
    Name = local.ip_set_admin_name
  }, var.tags)
}

resource "aws_wafv2_ip_set" "whitelist" {
  name               = local.ip_set_whitelist_name
  description        = var.description
  scope              = var.scope
  ip_address_version = "IPV4"
  addresses          = var.whitelist_ipv4

  tags = merge({
    Name = local.ip_set_whitelist_name
  }, var.tags)
}

resource "aws_wafv2_ip_set" "blacklist" {
  name               = local.ip_set_blacklist_name
  description        = var.description
  scope              = var.scope
  ip_address_version = "IPV4"
  addresses          = var.blacklist_ipv4

  tags = merge({
    Name = local.ip_set_blacklist_name
  }, var.tags)
}

resource "aws_wafv2_web_acl" "core" {
  name        = local.acl_core_name
  description = var.description
  scope       = var.scope

  default_action {
    allow {}
  }

  dynamic "rule" {
    for_each = length(var.whitelist_ipv4) == 0 ? [] : [1]

    content {
      name     = local.rule_whitelist_ips
      priority = 1

      action {
        block {
          custom_response {
            custom_response_body_key = local.waf_custom_response_body_key
            response_code            = 403
            response_header {
              name  = local.waf_header
              value = local.rule_whitelist_ips
            }
          }
        }
      }

      statement {
        not_statement {
          statement {
            ip_set_reference_statement {
              arn = aws_wafv2_ip_set.whitelist.arn
            }
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
        metric_name                = local.rule_whitelist_ips
        sampled_requests_enabled   = true
      }
    }
  }

  dynamic "rule" {
    for_each = length(var.blacklist_ipv4) == 0 ? [] : [1]

    content {
      name     = local.rule_blacklist_ips
      priority = 3

      action {
        block {
          custom_response {
            custom_response_body_key = local.waf_custom_response_body_key
            response_code            = 403
            response_header {
              name  = local.waf_header
              value = local.rule_blacklist_ips
            }
          }
        }
      }

      statement {
        ip_set_reference_statement {
          arn = aws_wafv2_ip_set.blacklist.arn
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
        metric_name                = local.rule_blacklist_ips
        sampled_requests_enabled   = true
      }
    }
  }

  rule {
    name     = format("%s-rule-ip", var.service_name)
    priority = 20

    action {
      block {
        custom_response {
          custom_response_body_key = local.waf_custom_response_body_key
          response_code            = 403
          response_header {
            name  = local.waf_header
            value = local.rule_ip_rate
          }
        }
      }
    }

    statement {
      rate_based_statement {
        limit              = var.ip_limit
        aggregate_key_type = "IP"

        scope_down_statement {
          not_statement {
            statement {
              ip_set_reference_statement {
                arn = aws_wafv2_ip_set.admin.arn
              }
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
      metric_name                = local.rule_ip_rate
      sampled_requests_enabled   = true
    }
  }

  dynamic "rule" {
    for_each = length(var.allowed_country_codes) == 0 ? [] : [1]

    content {
      name     = local.rule_whitelist_country_name
      priority = 2

      action {
        block {
          custom_response {
            custom_response_body_key = local.waf_custom_response_body_key
            response_code            = 403
            response_header {
              name  = local.waf_header
              value = local.rule_whitelist_country_name
            }
          }
        }
      }

      statement {
        not_statement {
          statement {
            geo_match_statement {
              country_codes = var.allowed_country_codes
            }
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
        metric_name                = local.rule_whitelist_country_name
        sampled_requests_enabled   = true
      }
    }
  }

  dynamic "rule" {
    for_each = var.managed_rules

    content {
      name     = format("%s-%s", var.service_name, rule.value.name)
      priority = rule.value.priority

      override_action {
        none {}
      }

      statement {
        managed_rule_group_statement {
          name        = rule.value.name
          vendor_name = "AWS"

          dynamic "excluded_rule" {
            for_each = rule.value.excluded_rules

            content {
              name = excluded_rule.value
            }
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
        metric_name                = format("waf-%s-%s", var.service_name, rule.value.name)
        sampled_requests_enabled   = true
      }
    }
  }

  custom_response_body {
    key          = local.waf_custom_response_body_key
    content_type = "APPLICATION_JSON"
    content      = format("{\"message\":\"%s\"}", var.forbidden_message)
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
    metric_name                = local.acl_core_name
    sampled_requests_enabled   = true
  }

  tags = merge({
    Name = local.acl_core_name
  }, var.tags)

}
