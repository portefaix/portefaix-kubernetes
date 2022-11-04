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
module "ssh_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.16.0"

  name        = format("%s-ssh", var.sg_name)
  description = "Security group which is to allow SSH from Bastion"
  vpc_id      = data.aws_vpc.this.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
}
