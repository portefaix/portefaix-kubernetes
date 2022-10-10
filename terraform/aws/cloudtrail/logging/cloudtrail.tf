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

module "cloudtrail" {
  source = "../modules/cloudtrail"

  providers = {
    aws         = aws
    aws.logging = aws.logging
  }

  org_name = var.org_name

  cloudtrail_name  = var.cloudtrail_name
  bucket_name      = var.bucket_name
  stream_name      = var.stream_name
  shard_count      = var.shard_count
  retention_period = var.retention_period
  sns_topic_name   = var.sns_topic_name

  tags = var.tags
}
