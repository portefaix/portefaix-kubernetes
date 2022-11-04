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

#############################################################################
# Provider

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags for the AWS provider"
  default = {
    "Project"           = "Portefaix"
    "Made-By"           = "Terraform"
    "Portefaix-Version" = "v0.41.0"
  }
}

#############################################################################
# Project

variable "org_name" {
  type        = string
  description = "Name of the AWS Organization"
}

variable "core_account_id" {
  type        = string
  description = "ID of the Core AWS Account"
}

#############################################################################
# Observability

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

# Prometheus

variable "prometheus_namespace" {
  type        = string
  description = "The Kubernetes namespace"
}

variable "prometheus_service_account" {
  type        = string
  description = "The Kubernetes service account"
}

variable "prometheus_tags" {
  type        = map(string)
  description = "Tags for Prometheus"
}

variable "prometheus_enable_kms" {
  type        = bool
  description = "Enable custom KMS key"
}

# Thanos

variable "thanos_namespace" {
  type        = string
  description = "The Kubernetes namespace"
}

variable "thanos_service_accounts" {
  type        = list(string)
  description = "The Kubernetes service account"
}

variable "thanos_tags" {
  type        = map(string)
  description = "Tags for Thanos"
}

variable "thanos_enable_kms" {
  type        = bool
  description = "Enable custom KMS key"
}

# Loki

variable "loki_namespace" {
  type        = string
  description = "The Kubernetes namespace"
}

variable "loki_service_account" {
  type        = string
  description = "The Kubernetes service account"
}

variable "loki_tags" {
  type        = map(string)
  description = "Tags for Loki"
}

variable "loki_enable_kms" {
  type        = bool
  description = "Enable custom KMS key"
}

# Tempo

variable "tempo_namespace" {
  type        = string
  description = "The Kubernetes namespace"
}

variable "tempo_service_account" {
  type        = string
  description = "The Kubernetes service account"
}

variable "tempo_tags" {
  type        = map(string)
  description = "Tags for Tempo"
}

variable "tempo_enable_kms" {
  type        = bool
  description = "Enable custom KMS key"
}

# Grafana

variable "grafana_namespace" {
  type        = string
  description = "The Kubernetes namespace"
}

variable "grafana_service_account" {
  type        = string
  description = "The Kubernetes service account"
}

variable "grafana_tags" {
  type        = map(string)
  description = "Tags for Grafana"
}

# AWS Managed Prometheus

variable "amp_alias" {
  description = "AWS Managed Prometheus workspace name"
  type        = string
}

variable "amp_tags" {
  type        = map(string)
  description = "Tags for AMP"
}
