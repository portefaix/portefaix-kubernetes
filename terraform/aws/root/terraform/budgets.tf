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

# locals {
#   aws_services = {
#     Athena         = "Amazon Athena"
#     EC2            = "Amazon Elastic Compute Cloud - Compute"
#     ECR            = "Amazon EC2 Container Registry (ECR)"
#     ECS            = "Amazon EC2 Container Service"
#     Kubernetes     = "Amazon Elastic Container Service for Kubernetes"
#     EBS            = "Amazon Elastic Block Store"
#     CloudFront     = "Amazon CloudFront"
#     CloudTrail     = "AWS CloudTrail"
#     CloudWatch     = "AmazonCloudWatch"
#     Cognito        = "Amazon Cognito"
#     Config         = "AWS Config"
#     DynamoDB       = "Amazon DynamoDB"
#     DMS            = "AWS Database Migration Service"
#     ElastiCache    = "Amazon ElastiCache"
#     Elasticsearch  = "Amazon Elasticsearch Service"
#     ELB            = "Amazon Elastic Load Balancing"
#     Gateway        = "Amazon API Gateway"
#     Glue           = "AWS Glue"
#     Kafka          = "Managed Streaming for Apache Kafka"
#     KMS            = "AWS Key Management Service"
#     Kinesis        = "Amazon Kinesis"
#     Lambda         = "AWS Lambda"
#     Lex            = "Amazon Lex"
#     Matillion      = "Matillion ETL for Amazon Redshift"
#     Pinpoint       = "AWS Pinpoint"
#     Polly          = "Amazon Polly"
#     Rekognition    = "Amazon Rekognition"
#     RDS            = "Amazon Relational Database Service"
#     Redshift       = "Amazon Redshift"
#     S3             = "Amazon Simple Storage Service"
#     SFTP           = "AWS Transfer for SFTP"
#     Route53        = "Amazon Route 53"
#     SageMaker      = "Amazon SageMaker"
#     SecretsManager = "AWS Secrets Manager"
#     SES            = "Amazon Simple Email Service"
#     SNS            = "Amazon Simple Notification Service"
#     SQS            = "Amazon Simple Queue Service"
#     Tax            = "Tax"
#     VPC            = "Amazon Virtual Private Cloud"
#     WAF            = "AWS WAF"
#     XRay           = "AWS X-Ray"
#   }
# }

#tfsec:ignore:aws-sns-enable-topic-encryption
resource "aws_sns_topic" "budgets_alarm" {
  name = local.sns_budget_topic_name

  tags = merge({
    "Name"    = local.sns_budget_topic_name,
    "Service" = "Budgets",
    },
    var.tags
  )
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    sid    = "AWSBudgetsSNSPublishingPermissions"
    effect = "Allow"

    actions = [
      "SNS:Receive",
      "SNS:Publish"
    ]

    principals {
      type        = "Service"
      identifiers = ["budgets.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.budgets_alarm.arn
    ]
  }
}

resource "aws_sns_topic_policy" "account_budgets_alarm_policy" {
  arn    = aws_sns_topic.budgets_alarm.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_budgets_budget" "root_everything_5" {
  name              = format("%s / ALL / Monthly 5", title(var.org_name))
  account_id        = data.aws_caller_identity.this.account_id
  budget_type       = "COST"
  limit_amount      = 5
  limit_unit        = var.budget_limit_unit
  time_unit         = var.budget_time_unit
  time_period_start = "2022-01-01_00:00"

  cost_types {
    include_credit             = true
    include_discount           = true
    include_other_subscription = true
    include_recurring          = true
    include_refund             = true
    include_subscription       = true
    include_support            = true
    include_tax                = true
    include_upfront            = true
    use_amortized              = false
    use_blended                = false
  }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 80
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
    subscriber_email_addresses = [
      local.budget_admin_email
    ]
  }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 70
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
    subscriber_sns_topic_arns = [
      aws_sns_topic.budgets_alarm.arn
    ]
  }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 100
    threshold_type      = "PERCENTAGE"
    notification_type   = "FORECASTED"
    subscriber_email_addresses = [
      local.budget_admin_email
    ]
  }
}

resource "aws_budgets_budget" "root_everything_25" {
  name              = format("%s / ALL / Monthly 25", title(var.org_name))
  account_id        = data.aws_caller_identity.this.account_id
  budget_type       = "COST"
  limit_amount      = 25
  limit_unit        = var.budget_limit_unit
  time_unit         = var.budget_time_unit
  time_period_start = "2022-01-01_00:00"

  cost_types {
    include_credit             = true
    include_discount           = true
    include_other_subscription = true
    include_recurring          = true
    include_refund             = true
    include_subscription       = true
    include_support            = true
    include_tax                = true
    include_upfront            = true
    use_amortized              = false
    use_blended                = false
  }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 80
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
    subscriber_email_addresses = [
      local.budget_admin_email
    ]
  }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 70
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
    subscriber_sns_topic_arns = [
      aws_sns_topic.budgets_alarm.arn
    ]
  }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 100
    threshold_type      = "PERCENTAGE"
    notification_type   = "FORECASTED"
    subscriber_email_addresses = [
      local.budget_admin_email
    ]
  }
}

resource "aws_budgets_budget" "accounts_all" {
  for_each = { for account in local.org_accounts : account.id => account }

  name              = format("%s-%s / ALL / Monthly", title(var.org_name), title(each.value.name))
  budget_type       = "COST"
  limit_amount      = 10
  limit_unit        = var.budget_limit_unit
  time_unit         = var.budget_time_unit
  time_period_start = "2022-01-01_00:00"

  cost_filter {
    name = "LinkedAccount"
    values = [
      # aws_organizations_account.shared.id
      each.key
    ]
  }

  cost_types {
    include_credit             = true
    include_discount           = true
    include_other_subscription = true
    include_recurring          = true
    include_refund             = true
    include_subscription       = true
    include_support            = true
    include_tax                = true
    include_upfront            = true
    use_amortized              = false
    use_blended                = false
  }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 80
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
    subscriber_email_addresses = [
      local.budget_admin_email
    ]
  }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 70
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
    subscriber_sns_topic_arns = [
      aws_sns_topic.budgets_alarm.arn
    ]
  }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 100
    threshold_type      = "PERCENTAGE"
    notification_type   = "FORECASTED"
    subscriber_email_addresses = [
      local.budget_admin_email
    ]
  }
}

# resource "aws_budgets_budget" "services" {
#   for_each = var.budget_services

#   name              = format("%s / %s / Monthly", title(var.org_name), each.key)
#   budget_type       = "COST"
#   limit_amount      = each.value.budget_limit
#   limit_unit        = var.budget_limit_unit
#   time_unit         = var.budget_time_unit
#   time_period_start = "2020-01-01_00:00"

#   cost_filter {
#     name = "Service"
#     values = [
#       lookup(local.aws_services, each.key)
#     ]
#   }

#   notification {
#     comparison_operator        = "GREATER_THAN"
#     threshold                  = 80
#     threshold_type             = "PERCENTAGE"
#     notification_type          = "ACTUAL"
#     subscriber_email_addresses = [
#       local.budget_admin_email
#     ]
#   }

#   notification {
#     comparison_operator        = "GREATER_THAN"
#     threshold                  = 70
#     threshold_type             = "PERCENTAGE"
#     notification_type          = "ACTUAL"
#     subscriber_sns_topic_arns = [
#       aws_sns_topic.budgets_alarm.arn
#     ]
#   }
#
# }
