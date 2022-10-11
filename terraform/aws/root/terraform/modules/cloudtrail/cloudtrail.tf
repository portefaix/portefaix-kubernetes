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
resource "aws_cloudtrail" "organizational_trail" {
  name                          = var.cloudtrail_name
  s3_bucket_name                = aws_s3_bucket.centralized_audit_logs.id
  include_global_service_events = true
  is_multi_region_trail         = true
  is_organization_trail         = true
  enable_log_file_validation    = true
  enable_logging                = var.cloudtrail_logging

  tags = merge({
    "Name" = var.cloudtrail_name
  }, var.tags)

  depends_on = [
    aws_s3_bucket_policy.cloudtrail_access,
  ]
}
