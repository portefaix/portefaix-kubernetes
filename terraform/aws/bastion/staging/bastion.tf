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

#tfsec:ignore:aws-vpc-no-public-ingress-sgr
#tfsec:ignore:aws-vpc-no-public-egress-sgr
module "bastion" {
  source = "../modules/bastion"

  vpc_name = var.vpc_name

  asg_name = var.asg_name
  asg_tags = var.asg_tags

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  instance_type    = var.instance_type

  sg_name = var.sg_name

  # key_name     = var.key_name
  # public_key   = var.public_key
  # ssh_key_tags = var.ssh_key_tags

  ec2_ssm_role_name = var.ec2_ssm_role_name
  ec2_ssm_tags      = var.ec2_ssm_tags
}
