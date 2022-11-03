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

#tfsec:ignore:aws-autoscaling-enforce-http-token-imds
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.5.3"

  name = var.asg_name

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  security_groups = [
    module.ssh_sg.security_group_id
  ]

  iam_instance_profile_name = module.ec2_ssm.iam_instance_profile_name

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 20
        volume_type           = "gp2"
      }
    },
    {
      device_name = "/dev/sda1"
      no_device   = 1
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 30
        volume_type           = "gp2"
      }
    }
  ]

  vpc_zone_identifier       = data.aws_subnets.public.ids
  health_check_type         = "EC2"
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  wait_for_capacity_timeout = 0
  # key_name                  = module.ssh_key.key_pair_key_name

  tags = var.asg_tags
}
