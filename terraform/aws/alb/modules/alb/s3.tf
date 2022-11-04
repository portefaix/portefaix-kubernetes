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

# resource "aws_s3_bucket" "logs" {
#   bucket = local.alb_logs_bucket_name
#   acl    = "private"

#   policy = <<POLICY
# {
#   "Id": "Policy",
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "s3:PutObject"
#       ],
#       "Effect": "Allow",
#       "Resource": "arn:aws:s3:::${var.alb_name}/*",
#       "Principal": {
#         "AWS": [
#           "${data.aws_elb_service_account.this.arn}"
#         ]
#       }
#     }
#   ]
# }
# POLICY
#   tags = merge({
#     "Name" = var.alb_name
#     "Role" = "logs"
#   }, var.alb_tags)
# }


#tfsec:ignore:AWS073
#tfsec:ignore:AWS074
#tfsec:ignore:AWS075
#tfsec:ignore:AWS076
module "logs" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.5.0"

  bucket = local.alb_logs_bucket_name
  acl    = "log-delivery-write"

  # Allow deletion of non-empty bucket
  force_destroy = true

  attach_elb_log_delivery_policy = true # Required for ALB logs
  attach_lb_log_delivery_policy  = true # Required for ALB/NLB logs

  versioning = {
    enabled = true
  }

  policy = <<POLICY
  {
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:PutObject"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::${var.alb_name}/*",
        "Principal": {
          "AWS": [
            "${data.aws_elb_service_account.this.arn}"
          ]
        }
      }
    ]
  }
  POLICY

  tags = merge({
    "Name" = var.alb_name
    "Role" = "logs"
  }, var.alb_tags)
}
