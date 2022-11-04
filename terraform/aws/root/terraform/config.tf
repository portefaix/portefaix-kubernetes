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

# module "config" {
#   source = "./modules/config"

#   # providers = {
#   #   aws         = aws
#   #   aws.logging = aws.logging
#   # }

#   org_name = var.org_name
#   region   = var.region

#   slack_webhook_url = var.slack_webhook_url
#   slack_channel     = var.slack_channel
#   slack_username    = var.slack_username

#   tags = merge({
#     "Service" = "AWS Config"
#     },
#   var.tags)
# }
