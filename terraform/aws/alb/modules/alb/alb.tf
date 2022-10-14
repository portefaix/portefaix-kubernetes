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

#tfsec:ignore:AWS004
#tfsec:ignore:AWS005
#tfsec:ignore:AWS083
module "alb_external" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.1.0"

  name      = local.alb_external_name
  subnets   = data.aws_subnet_ids.public.ids
  create_lb = true
  internal  = false

  security_groups = [
    aws_security_group.alb_external.id,
  ]

  access_logs = {
    bucket = module.logs.s3_bucket_id #aws_s3_bucket.logs.id
    prefix = local.alb_external_name
  }

  # https_listeners = [
  #   {
  #     certificate_arn = data.aws_acm_certificate.env.arn
  #     port            = 443
  #     action_type     = "fixed-response"
  #     fixed_response = {
  #       content_type = "text/plain"
  #       status_code  = 200
  #       message_body = ""
  #     }
  #   },
  # ]

  http_tcp_listeners = [
    {
      port        = "80"
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    },
  ]

  tags = merge({
    "Name" = local.alb_external_name
    "Role" = "external",
  }, var.alb_tags)

  vpc_id = data.aws_vpc.this.id

}

module "alb_internal" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.1.0"

  name      = local.alb_internal_name
  subnets   = data.aws_subnet_ids.private.ids
  create_lb = true
  internal  = true

  security_groups = [
    aws_security_group.alb_internal.id
  ]

  access_logs = {
    bucket = module.logs.s3_bucket_id #aws_s3_bucket.logs.id
    prefix = local.alb_internal_name
  }

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        status_code  = 200
        message_body = ""
      }
    },
  ]

  tags = merge({
    "Name" = local.alb_internal_name
    "Role" = "internal",
  }, var.alb_tags)

  vpc_id = data.aws_vpc.this.id
}
