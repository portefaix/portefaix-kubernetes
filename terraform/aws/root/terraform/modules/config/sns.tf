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

#tfsec:ignore:aws-sns-enable-topic-encryption
#tfsec:ignore:aws-lambda-enable-tracing
#tfsec:ignore:aws-lambda-restrict-source-arn
module "notify_slack" {
  source  = "terraform-aws-modules/notify-slack/aws"
  version = "5.4.0"

  sns_topic_name = local.sns_topic_name

  slack_webhook_url = var.slack_webhook_url
  slack_channel     = var.slack_channel
  slack_username    = var.slack_username

  tags = merge({
    "Name" = local.sns_topic_name,
    Role   = "SNS"
    },
    var.tags
  )
}
