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

module "sns_topic" {
  source  = "terraform-aws-modules/sns/aws"
  version = "4.0.0"

  providers = {
    aws = aws.audit
  }

  create_sns_topic = var.sns_create_topic
  name             = local.sns_topic_name
  display_name     = var.display_name

  tags = merge({
    Name = local.sns_topic_name
  }, var.tags)
}
