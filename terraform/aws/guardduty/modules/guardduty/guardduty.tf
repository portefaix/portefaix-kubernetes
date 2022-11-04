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

resource "aws_guardduty_detector" "this" {
  provider = aws.audit
  enable   = true

  # Additional setting to turn on S3 Protection
  datasources {
    s3_logs {
      enable = true
    }
  }

  tags = merge({
    Env = "Audit"
  }, var.tags)
}

# resource "aws_guardduty_publishing_destination" "this" {
#   provider   = aws.security
#   depends_on = [aws_guardduty_organization_admin_account.this]

#   detector_id     = aws_guardduty_detector.this.id
#   destination_arn = var.gd_publishing_dest_bucket_arn
#   kms_key_arn     = var.gd_kms_key_arn
# }
