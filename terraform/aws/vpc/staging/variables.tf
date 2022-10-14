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
# VPC

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "vpc_subnet_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "The VPC Subnet CIDR"
}

variable "private_subnet_cidr" {
  default     = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
  type        = list(any)
  description = "Private Subnet CIDR"
}

variable "public_subnet_cidr" {
  default     = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]
  type        = list(any)
  description = "Public Subnet CIDR"
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
}

variable "vpc_tags" {
  type        = map(string)
  description = "Tags for VPC"
  default = {
    "Service" = "VPC"
  }
}

variable "private_subnet_tags" {
  type        = map(string)
  description = "Tags for private subnets"
  default = {
    "Service" = "Subnets"
  }
}

variable "public_subnet_tags" {
  type        = map(string)
  description = "Tags for public subnets"
  default = {
    "Service" = "Subnets"
  }
}

variable "eks_cluster_name" {
  type        = string
  description = "The name of your EKS Cluster"
}

#############################################################################
# Internet Gateway

variable "igw_tags" {
  type        = map(string)
  description = "Tags for Internet NAT Gateway"
  default = {
    "Service" = "Internet Gateway"
  }
}
