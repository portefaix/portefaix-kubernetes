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

module "prometheus" {
  source  = "nlamirault/observability/google//modules/prometheus"
  version = "2.0.0"

  project = var.project

  account_id   = var.prometheus_account_id
  display_name = var.prometheus_display_name

  secret_location = var.prometheus_secret_location
  secret_labels   = var.prometheus_secret_labels

  workload_identity_enable = true
  namespace                = var.prometheus_namespace
  service_account          = var.prometheus_service_account
}

module "thanos" {
  source  = "nlamirault/observability/google//modules/thanos"
  version = "2.0.0"

  project = var.project

  account_id   = var.thanos_account_id
  display_name = var.thanos_display_name

  bucket_location      = var.thanos_bucket_location
  bucket_storage_class = var.thanos_bucket_storage_class
  bucket_labels        = var.thanos_bucket_labels

  secret_location = var.thanos_secret_location
  secret_labels   = var.thanos_secret_labels

  workload_identity_enable = true
  namespace                = var.thanos_namespace
  service_account          = var.thanos_service_account
}

module "loki" {
  source  = "nlamirault/observability/google//modules/loki"
  version = "2.0.0"

  project = var.project

  account_id   = var.loki_account_id
  display_name = var.loki_display_name

  bucket_location      = var.loki_bucket_location
  bucket_storage_class = var.loki_bucket_storage_class
  bucket_labels        = var.loki_bucket_labels

  secret_location = var.loki_secret_location
  secret_labels   = var.loki_secret_labels

  workload_identity_enable = true
  namespace                = var.loki_namespace
  service_account          = var.loki_service_account
}

module "tempo" {
  source  = "nlamirault/observability/google//modules/tempo/"
  version = "2.0.0"

  project = var.project

  account_id   = var.tempo_account_id
  display_name = var.tempo_display_name

  bucket_location      = var.tempo_bucket_location
  bucket_storage_class = var.tempo_bucket_storage_class
  bucket_labels        = var.tempo_bucket_labels

  secret_location = var.tempo_secret_location
  secret_labels   = var.tempo_secret_labels

  workload_identity_enable = true
  namespace                = var.tempo_namespace
  service_account          = var.tempo_service_account
}

