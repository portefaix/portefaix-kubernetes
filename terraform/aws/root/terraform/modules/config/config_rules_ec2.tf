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

resource "aws_config_config_rule" "ec2_instances_vpc" {
  name        = format("%s-ec2-instances-in-vpc", var.org_name)
  description = "Ensure all EC2 instances run in a VPC"

  source {
    owner             = "AWS"
    source_identifier = "INSTANCES_IN_VPC"
  }

  tags = merge({
    Name = format("%s-ec2-instances-in-vpc", var.org_name)
    Role = "EC2"
  }, var.tags)

  depends_on = [aws_config_configuration_recorder.this]
}

resource "aws_config_config_rule" "eip_attached" {
  name        = format("%s-ec2-eip-attached", var.org_name)
  description = "Checks whether all Elastic IP addresses that are allocated to a VPC are attached to EC2 instances or in-use elastic network interfaces (ENIs)."

  source {
    owner             = "AWS"
    source_identifier = "EIP_ATTACHED"
  }

  tags = merge({
    Name = format("%s-ec2-eip-attached", var.org_name)
    Role = "EC2"
  }, var.tags)

  depends_on = [aws_config_configuration_recorder.this]
}

resource "aws_config_config_rule" "ec2_instance_no_public_ip" {
  name        = format("%s-ec2-instance-no-public-ip", var.org_name)
  description = "ec2-instance no public ip"

  source {
    owner             = "AWS"
    source_identifier = "EC2_INSTANCE_NO_PUBLIC_IP"
  }

  tags = merge({
    Name = format("%s-ec2-instance-no-public-ip", var.org_name)
    Role = "EC2"
  }, var.tags)

  depends_on = [aws_config_configuration_recorder.this]
}