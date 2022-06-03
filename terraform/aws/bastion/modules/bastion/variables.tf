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
# Networking

variable "vpc_name" {
  type        = string
  description = "ID of the VPC"
}


#############################################################################
# IAM

variable "ec2_ssm_role_name" {
  type        = string
  description = "Name of the AWS project"
}

variable "ec2_ssm_tags" {
  type        = map(string)
  description = "Tags for the bastion"
  default = {
    "made-by" = "terraform"
  }
}

#############################################################################
# Bastion

variable "asg_name" {
  type        = string
  description = "Name of the bastion ASG"
}

variable "asg_tags" {
  type        = map(string)
  description = "Tags for the bastion"
  default = {
    "made-by" = "terraform"
  }
}

variable "min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
}

variable "max_size" {
  description = "The maximum size of the autoscaling group"
  type        = number
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the autoscaling group"
  type        = number
}

variable "instance_type" {
  description = "The type of the instance to launch"
  type        = string
}

variable "sg_name" {
  type        = string
  description = "Name for the security groups"
}

# SSH Key

# variable "key_name" {
#   description = "The key name that should be used for the instance"
#   type        = string
#   default     = null
# }


# variable "public_key" {
#   description = "The public key material."
#   type        = string
# }

# variable "ssh_key_tags" {
#   description = "A map of tags to add to key pair resource."
#   type        = map(string)
# }
