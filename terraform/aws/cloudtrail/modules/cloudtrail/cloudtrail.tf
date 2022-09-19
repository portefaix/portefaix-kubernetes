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

#tfsec:ignore:aws-cloudtrail-enable-at-rest-encryption
#tfsec:ignore:aws-cloudtrail-enable-log-validation
resource "aws_cloudtrail" "this" {
  name                  = var.cloudtrail_name
  is_organization_trail = true
  is_multi_region_trail = true

  s3_bucket_name = data.aws_s3_bucket.cloudtrail_logs.id
  s3_key_prefix  = var.org_name

  sns_topic_name = var.sns_topic_name

  include_global_service_events = true # Mandatory for multi-region trails

  tags = merge({
    "Name" = var.org_name
  }, var.tags)
}
