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

output "id" {
  description = "Contains the EIP allocation ID"
  value       = aws_eip.internet_gateway.id
}

output "public_ip" {
  description = "Contains the public IP address"
  value       = aws_eip.internet_gateway.public_ip
}

output "public_dns" {
  description = "Public DNS associated with the Elastic IP address"
  value       = aws_eip.internet_gateway.public_dns
}
