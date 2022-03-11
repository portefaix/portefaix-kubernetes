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

module "observability" {
  source = "../modules/observability"

  project = var.project

  prometheus_namespace       = var.prometheus_namespace
  prometheus_service_account = var.prometheus_service_account

  thanos_bucket_location         = var.thanos_bucket_location
  thanos_bucket_storage_class    = var.thanos_bucket_storage_class
  thanos_bucket_labels           = var.thanos_bucket_labels
  thanos_namespace               = var.thanos_namespace
  thanos_service_account         = var.thanos_service_account
  thanos_sidecar_service_account = var.thanos_sidecar_service_account
  thanos_enable_kms              = var.thanos_enable_kms
  thanos_keyring_location        = var.thanos_keyring_location
  thanos_keys                    = var.thanos_keys
  thanos_kms_labels              = var.thanos_kms_labels

  loki_bucket_location      = var.loki_bucket_location
  loki_bucket_storage_class = var.loki_bucket_storage_class
  loki_bucket_labels        = var.loki_bucket_labels
  loki_namespace            = var.loki_namespace
  loki_service_account      = var.loki_service_account
  loki_enable_kms           = var.loki_enable_kms
  loki_keyring_location     = var.loki_keyring_location
  loki_keys                 = var.loki_keys
  loki_kms_labels           = var.loki_kms_labels

  tempo_bucket_location      = var.tempo_bucket_location
  tempo_bucket_storage_class = var.tempo_bucket_storage_class
  tempo_bucket_labels        = var.tempo_bucket_labels
  tempo_namespace            = var.tempo_namespace
  tempo_service_account      = var.tempo_service_account
  tempo_enable_kms           = var.tempo_enable_kms
  tempo_keyring_location     = var.tempo_keyring_location
  tempo_keys                 = var.tempo_keys
  tempo_kms_labels           = var.tempo_kms_labels

  grafana_namespace       = var.grafana_namespace
  grafana_service_account = var.grafana_service_account
}
