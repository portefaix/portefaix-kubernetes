# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

output "prometheus_role_arn" {
  description = "Role ARN for Prometheus"
  value       = module.prometheus.role_arn
}

output "prometheus_kms_arn" {
  description = "KMS ARN for Prometheus"
  value       = module.prometheus.kms_arn
}

output "thanos_role_arn" {
  description = "Role ARN for Thanos"
  value       = module.thanos.role_arn
}

output "thanos_kms_arn" {
  description = "KMS ARN for Thanos"
  value       = module.thanos.kms_arn
}

output "loki_role_arn" {
  description = "Role ARN for Loki"
  value       = module.loki.role_arn
}

output "loki_kms_arn" {
  description = "KMS ARN for Loki"
  value       = module.loki.kms_arn
}

output "tempo_role_arn" {
  description = "Role ARN for Tempo"
  value       = module.tempo.role_arn
}

output "tempo_kms_arn" {
  description = "KMS ARN for Tempo"
  value       = module.tempo.kms_arn
}