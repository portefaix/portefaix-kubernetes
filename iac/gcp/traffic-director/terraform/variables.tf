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

############################################################################
# Provider

variable "project" {
  type        = string
  description = "The project in which the resource belongs"
}

variable "region" {
  type        = string
  description = "The region in which the cluster should be created."
}

############################################################################
# VPC

variable "network_name" {
  type        = string
  description = "Name of the VPC"
}

############################################################################
# Traffic Director

variable "gke_service_name" {
  type        = string
  description = "The Kubernetes service name"
}

variable "gke_service_port" {
  type        = number
  description = "The Kubernetes service port"
}

variable "neg_name" {
  type        = string
  description = "Network Endpoint Group name"
}

variable "neg_zone" {
  type        = string
  description = "Network Endpoint Group zone"
}

variable hc_timeout_sec {
  type        = number
  description = "How long (in seconds) to wait before claiming failure"
  default     = 5
}

variable hc_check_interval_sec {
  type        = number
  description = "How often (in seconds) to send a health check"
  default     = 5
}

variable "hc_log_config" {
  type        = bool
  description = "Configure logging on this health check"
  default     = false
}

