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

data "aws_iam_policy_document" "fis_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["fis.amazonaws.com"]
    }
  }
}

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "fis" {
  statement {
    sid    = "AllowFISExperimentLoggingActionsCloudwatch"
    effect = "Allow"
    actions = [
      "logs:CreateLogDelivery",
      "logs:PutResourcePolicy",
      "logs:DescribeResourcePolicies",
      "logs:DescribeLogGroups"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowFISExperimentRoleReadOnly"
    effect = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "ecs:DescribeClusters",
      "ecs:ListContainerInstances",
      "eks:DescribeNodegroup",
      "iam:ListRoles",
      "rds:DescribeDBInstances",
      "rds:DescribeDbClusters",
      "ssm:ListCommands"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowFISExperimentRoleEC2Actions"
    effect = "Allow"
    actions = [
      "ec2:RebootInstances",
      "ec2:StopInstances",
      "ec2:StartInstances",
      "ec2:TerminateInstances"
    ]
    resources = ["arn:aws:ec2:*:*:instance/*"]
  }
  statement {
    sid    = "AllowFISExperimentRoleECSActions"
    effect = "Allow"
    actions = [
      "ecs:UpdateContainerInstancesState",
      "ecs:ListContainerInstances"
    ]
    resources = ["arn:aws:ecs:*:*:container-instance/*"]
  }
  statement {
    sid    = "AllowFISExperimentRoleEKSActions"
    effect = "Allow"
    actions = [
      "ec2:TerminateInstances"
    ]
    resources = ["arn:aws:ec2:*:*:instance/*"]
  }
  statement {
    sid    = "AllowFISExperimentRoleFISActions"
    effect = "Allow"
    actions = [
      "fis:InjectApiInternalError",
      "fis:InjectApiThrottleError",
      "fis:InjectApiUnavailableError"
    ]
    resources = ["arn:*:fis:*:*:experiment/*"]
  }
  statement {
    sid    = "AllowFISExperimentRoleRDSReboot"
    effect = "Allow"
    actions = [
      "rds:RebootDBInstance"
    ]
    resources = ["arn:aws:rds:*:*:db:*"]
  }
  statement {
    sid    = "AllowFISExperimentRoleRDSFailOver"
    effect = "Allow"
    actions = [
      "rds:FailoverDBCluster"
    ]
    resources = ["arn:aws:rds:*:*:cluster:*"]
  }
  statement {
    sid    = "AllowFISExperimentRoleSSMSendCommand"
    effect = "Allow"
    actions = [
      "ssm:SendCommand"
    ]
    resources = [
      "arn:aws:ec2:*:*:instance/*",
      "arn:aws:ssm:*:*:document/*"
    ]
  }
  statement {
    sid    = "AllowFISExperimentRoleSSMCancelCommand"
    effect = "Allow"
    actions = [
      "ssm:CancelCommand"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "fis" {
  name        = local.fis_role_policy_name
  path        = "/"
  description = "Permissions for AWS FIS"
  policy      = data.aws_iam_policy_document.fis.json
  tags = merge(
    { "Name" = local.fis_role_policy_name },
    local.tags
  )
}

resource "aws_iam_role" "fis" {
  name               = format("%sRole", local.fis_service_name)
  assume_role_policy = data.aws_iam_policy_document.fis_assume_role.json

  tags = merge({
    Name = format("%sRole", local.fis_service_name)
  }, var.tags)
}

resource "aws_iam_role" "fis_assume_role" {
  name               = format("%sAssumeRole", local.fis_service_name)
  assume_role_policy = data.aws_iam_policy_document.fis_assume_role.json

  tags = merge({
    Name = format("%sAssumeRole", local.fis_service_name)
  }, var.tags)
}
