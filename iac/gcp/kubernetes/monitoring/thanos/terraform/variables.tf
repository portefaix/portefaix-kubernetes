# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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


#####################################################################""
# Provider

variable "project" {
  type        = string
  description = "The project in which the resource belongs"
}

variable "region" {
  type        = string
  description = "The location linked to the project"
}

variable "cluster_name" {
  type        = string
  description = "The Kubernetes cluster name"
}

variable "cluster_zone" {
  type        = string
  description = "The Kubernetes cluster's zone"
}

#####################################################################""
# Chart

variable "chart_repository" {
  type        = string
  description = "Repository URL where to locate the requested chart"
  default     = "https://kubernetes-charts.banzaicloud.com"
}

variable "chart_name" {
  type        = string
  description = "Chart name to be installed"
  default     = "thanos"
}

variable "chart_namespace" {
  type        = string
  description = "The namespace to install the release into"
  default     = "monitoring"
}

variable "chart_release_name" {
  type        = string
  description = "Release name"
  default     = "thanos"
}

variable "chart_version" {
  type        = string
  description = "Chart version to install"
}

variable "chart_values_filename" {
  type        = string
  description = "Filename for Helm chart values"
}

#####################################################################""
# Chart

variable "secret_filename" {
  type        = string
  description = "Secret filename"
}

variable "secret_name" {
  type        = string
  description = "Secret name"
}

variable "k8s_service_account_name" {
  type        = string
  description = "Kubernetes service account"
}

variable "gcp_service_account_name" {
  type        = string
  description = "GCP service account"
}

#####################################################################""
# Chart Mixin

variable "chart_mixin_repository" {
  type        = string
  description = "Repository URL where to locate the requested chart"
  default     = "https://charts.portefaix.xyz"
}

variable "chart_mixin_name" {
  type        = string
  description = "Chart name to be installed"
  default     = "thanos-mixin"
}

variable "chart_mixin_namespace" {
  type        = string
  description = "The namespace to install the release into"
  default     = "monitoring"
}

variable "chart_mixin_release_name" {
  type        = string
  description = "Release name"
  default     = "thanos-mixin"
}

variable "chart_mixin_version" {
  type        = string
  description = "Chart version to install"
}
