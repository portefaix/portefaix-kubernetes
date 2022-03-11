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

output "vpc_id" {
  description = "The VPC id"
  value       = module.vpc.this_vpc_id
}

output "vpc_name" {
  description = "The VPC name"
  value       = module.vpc.this_vpc_name
}

output "vswitch_ids" {
  description = "List of vswitch ids"
  value       = module.vpc.this_vswitch_ids
}

output "vswitch_names" {
  description = "List of vswitch names"
  value       = module.vpc.this_vswitch_names
}

output "pod_vswitch_ids" {
  description = "List of vswitch ids for pod"
  value       = alicloud_vswitch.pod_vswitch.*.id
}

output "pod_vswitch_names" {
  description = "List of vswitch names for pod"
  value       = alicloud_vswitch.pod_vswitch.*.name
}
