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

#############################################################################
# Provider

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags for the AWS provider"
  default = {
    "Project"           = "Portefaix"
    "Made-By"           = "Terraform"
    "Portefaix-Version" = "v0.41.0"
  }
}

#############################################################################
# Project

variable "org_name" {
  type        = string
  description = "Name of the AWS Organization"
}

variable "core_account_id" {
  type        = string
  description = "ID of the Core AWS Account"
}

#############################################################################
# AWS Load Balancer

variable "vpc_name" {
  type        = string
  description = "ID of the VPC"
}

variable "alb_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "alb_tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default = {
    "Service" = "ALB"
  }
}
