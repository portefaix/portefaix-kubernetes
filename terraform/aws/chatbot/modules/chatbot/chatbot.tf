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

module "chatbot" {
  source  = "waveaccounting/chatbot-slack-configuration/aws"
  version = "1.1.0"

  chatbot_role_permissions_boundary_policy_arn = var.role_permissions_boundary_policy_arn

  configuration_name = var.name
  slack_channel_id   = var.slack_channel_id
  slack_workspace_id = var.slack_workspace_id
  log_level          = var.log_level

  iam_role_arn = aws_iam_role.this.arn

  sns_topic_arns = [
    data.aws_sns_topic.this.arn,
  ]

  allow_notifications    = var.allow_notifications
  allow_labmda_invoke    = var.allow_labmda_invoke
  allow_support_access   = var.allow_support_access
  allow_read_only_access = var.allow_read_only_access

  tags = var.tags
}
