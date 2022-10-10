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

resource "aws_config_configuration_recorder" "this" {
  name     = local.service_name
  role_arn = aws_iam_role.this.arn
  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_configuration_aggregator" "this" {
  name = title(var.org_name)

  organization_aggregation_source {
    role_arn = aws_iam_role.organization.arn
    regions  = [var.region]
  }
}

resource "aws_config_delivery_channel" "this" {
  name           = aws_config_configuration_recorder.this.name
  s3_bucket_name = module.bucket_awsconfig.s3_bucket_id
  sns_topic_arn  = module.notify_slack.slack_topic_arn

  snapshot_delivery_properties {
    delivery_frequency = var.delivery_frequency
  }

  depends_on = [aws_config_configuration_recorder.this]
}

resource "aws_config_configuration_recorder_status" "this" {
  name       = aws_config_delivery_channel.this.name
  is_enabled = var.recorder_enabled
}
