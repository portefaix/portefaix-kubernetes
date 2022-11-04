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

resource "aws_config_config_rule" "s3_bucket_versioning" {
  name        = format("%s-s3-bucket-versioning", var.org_name)
  description = "Needs description"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }

  tags = merge({
    Name = format("%s-s3-bucket-versioning", var.org_name)
    Role = "S3"
  }, var.tags)

  depends_on = [aws_config_configuration_recorder.this]
}