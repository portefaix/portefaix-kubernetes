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

output "k8s_name" {
  description = "Name of the kunernetes cluster."
  value       = module.ack.this_k8s_name
}

output "k8s_id" {
  description = "ID of the kunernetes cluster."
  value       = module.ack.this_k8s_id
}

output "k8s_nodes" {
  description = "List nodes of cluster."
  value       = module.ack.this_k8s_nodes
}
