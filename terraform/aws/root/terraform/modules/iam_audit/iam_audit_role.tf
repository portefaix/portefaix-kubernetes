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

data "aws_iam_policy_document" "audit_policy" {
  statement {
    sid = "OrganizationAudit"
    actions = [
      "organizations:Describe*",
      "organizations:List*",
      "account:GetAlternateContact"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid = "IAMAudit"
    actions = [
      "iam:GenerateCredentialReport",
      "iam:GenerateServiceLastAccessedDetails",
      "iam:Get*",
      "iam:List*",
      "iam:SimulateCustomPolicy",
      "iam:SimulatePrincipalPolicy"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "WAFAudit"
    actions = [
      "waf:Get*",
      "waf:List*",
      "waf-regional:Get*",
      "waf-regional:List*",
      "wafv2:Get*",
      "wafv2:List*",
      "wafv2:Describe*",
      "wafv2:CheckCapacity"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "CloudTrailAudit"
    actions = [
      "cloudtrail:Get*",
      "cloudtrail:Describe*",
      "cloudtrail:List*",
      "cloudtrail:LookupEvents"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "CloudwatchLogsAudit"
    actions = [
      "logs:Describe*",
      "logs:Get*",
      "logs:List*",
      "logs:StartQuery",
      "logs:StopQuery",
      "logs:TestMetricFilter",
      "logs:FilterLogEvents"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "CloudwatchAudit"
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "sns:Get*",
      "sns:List*"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "EC2VPCAudit"
    actions = [
      "ec2:Describe*",
      "ec2:GetSubnetCidrReservations",
      "elasticloadbalancing:Describe*",
      "autoscaling:Describe*",
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "S3Audit"
    actions = [
      "s3:Get*",
      "s3:List*",
      "s3-object-lambda:Get*",
      "s3-object-lambda:List*"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "S3DenyAudit"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]
    resources = ["*"]
    effect    = "Deny"
  }
  statement {
    sid = "RDSAudit"
    actions = [
      "rds:Describe*",
      "rds:ListTagsForResource"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "ESAudit"
    actions = [
      "es:Describe*",
      "es:List*",
      "es:Get*"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "ECRAudit"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:ListTagsForResource",
      "ecr:DescribeImageScanFindings",
      "ecr:DescribeRegistry",
      "ecr:GetRegistryPolicy",
      "ecr:GetRegistryScanningConfiguration",

      "ecr-public:DescribeRegistries",
      "ecr-public:DescribeImageTags",
      "ecr-public:DescribeRepositories"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "Route53Audit"
    actions = [
      "route53domainregistration:GetDomainDetail",
      "route53domainregistration:ListDomains",
      "route53:Get*",
      "route53:List*",
      "route53resolver:Get*",
      "route53resolver:List*"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "EKSAudit"
    actions = [
      "eks:Describe*",
      "eks:List*",
      "eks:AccessKubernetesApi"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "SQSAudit"
    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:ListQueues"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "LambdaAudit"
    actions = [
      "cloudformation:DescribeStacks",
      "cloudformation:ListStackResources",
      "cloudwatch:GetMetricData",
      "cloudwatch:ListMetrics",
      "lambda:Get*",
      "lambda:List*",
      "states:DescribeStateMachine",
      "states:ListStateMachines",
      "tag:GetResources",
      "xray:GetTraceSummaries",
      "xray:BatchGetTraces"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid = "MiscAudit"
    actions = [
      "access-analyzer:ListPolicyGenerations",
      "network-firewall:List*",
      "network-firewall:Describe*",
      "cognito-idp:ListUserPools"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "audit_rights" {
  name   = format("%s%s", title(var.org_name), local.service_name)
  policy = data.aws_iam_policy_document.audit_policy.json
}
