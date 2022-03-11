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

output "prometheus_user_assigned_identity_id" {
  value       = module.prometheus.user_assigned_identity_id
  description = "ID of the user assigned identity"
}

output "prometheus_user_assigned_identity_name" {
  value       = module.prometheus.user_assigned_identity_name
  description = "Name of the user assigned identity"
}

output "thanos_user_assigned_identity_id" {
  value       = module.thanos.user_assigned_identity_id
  description = "ID of the user assigned identity"
}

output "thanos_user_assigned_identity_name" {
  value       = module.thanos.user_assigned_identity_name
  description = "Name of the user assigned identity"
}

output "loki_user_assigned_identity_id" {
  value       = module.loki.user_assigned_identity_id
  description = "ID of the user assigned identity"
}

output "loki_user_assigned_identity_name" {
  value       = module.loki.user_assigned_identity_name
  description = "Name of the user assigned identity"
}

output "tempo_user_assigned_identity_id" {
  value       = module.tempo.user_assigned_identity_id
  description = "ID of the user assigned identity"
}

output "tempo_user_assigned_identity_name" {
  value       = module.tempo.user_assigned_identity_name
  description = "Name of the user assigned identity"
}
