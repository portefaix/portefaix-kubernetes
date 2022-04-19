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

# External

#tfsec:ignore:AWS006
# module "external_http_80" {
#   source  = "terraform-aws-modules/security-group/aws//modules/http-80"
#   version = "4.4.0"

#   name        = local.alb_external_name
#   description = "Security group for web-server with HTTP ports open within VPC"
#   vpc_id      = data.aws_vpc.this.id

#   ingress_cidr_blocks = ["0.0.0.0/0"]

#   tags = merge({
#     "Name" = local.alb_external_name
#     "Role" = "internal",
#   }, var.alb_tags)
# }

# module "external_https_443" {
#   source  = "terraform-aws-modules/security-group/aws//modules/https-443"
#   version = "4.4.0"

#   name        = local.alb_external_name
#   description = "Security group for web-server with HTTPS ports open within VPC"
#   vpc_id      = data.aws_vpc.this.id

#   ingress_cidr_blocks = ["0.0.0.0/0"]

#   tags = merge({
#     "Name" = local.alb_internal_name
#     "Role" = "internal",
#   }, var.alb_tags)
# }

resource "aws_security_group" "alb_external" {
  name        = local.alb_external_name
  description = "Allow all HTTP and HTTPS inbound traffic"

  vpc_id = data.aws_vpc.this.id

  #tfsec:ignore:AWS018
  egress {
    description = "Allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    #tfsec:ignore:AWS009
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    "Name" = local.alb_external_name
    "Role" = "external",
  }, var.alb_tags)

  lifecycle {
    create_before_destroy = "true"
    ignore_changes        = [ingress]
  }
}

resource "aws_security_group_rule" "allow_http_external" {
  type        = "ingress"
  description = "Allow HTTP inbound traffic"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  #tfsec:ignore:AWS006
  #tfsec:ignore:AWS009
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_external.id
}

resource "aws_security_group_rule" "allow_https_external" {
  type        = "ingress"
  description = "Allow HTTPS inbound traffic"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  #tfsec:ignore:AWS006
  #tfsec:ignore:AWS009
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_external.id
}

# Internal

resource "aws_security_group" "alb_internal" {
  name        = local.alb_internal_name
  description = "Allow all HTTP and HTTPS inbound traffic from VPC"

  vpc_id = data.aws_vpc.this.id

  egress {
    description = "Allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    #tfsec:ignore:AWS009
    #tfsec:ignore:AWS018
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    "Name" = local.alb_internal_name
    "Role" = "internal",
  }, var.alb_tags)

  lifecycle {
    create_before_destroy = "true"
    ignore_changes        = [ingress]
  }
}

resource "aws_security_group_rule" "allow_http_internal" {
  type              = "ingress"
  description       = "Allow HTTP inbound traffic"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/8"]
  security_group_id = aws_security_group.alb_internal.id
}
