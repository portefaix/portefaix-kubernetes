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

######################################################################
# Provider

variable "project" {
  type        = string
  description = "The project in which the resource belongs"
}

variable "region" {
  type        = string
  description = "The location linked to the project"
}

############################################################################
# VPC

variable "network_name" {
  type        = string
  description = "Name of the VPC"
}

##############################################################################
# Bastion

variable "tags" {
  type        = list(string)
  description = "Network tags, provided as a list"
}

variable "labels" {
  type        = map(string)
  description = "Key-value map of labels to assign to the bastion host"
}

variable "machine_type" {
  type        = string
  description = "Instance type for the Bastion host"
}

variable "members" {
  type        = list(string)
  description = "List of IAM resources to allow access to the bastion host"
}

variable "name" {
  type        = string
  description = "Name of the Bastion instance"
}

variable "scopes" {
  type = list(string)

  description = "List of scopes to attach to the bastion host"
  default     = ["cloud-platform"]
}

variable "service_account_roles" {
  type = list(string)

  description = "List of IAM roles to assign to the service account."
  default = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/compute.osLogin",
  ]
}

variable "shielded_vm" {
  type = bool

  description = "Enable shielded VM on the bastion host (recommended)"
  default     = true
}

variable "zone" {
  type = string

  description = "The primary zone where the bastion host will live"
}

variable "disk_size_gb" {
  type        = string
  description = "Boot disk size in GB"
}

variable "disk_type" {
  type        = string
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  default     = "pd-standard"
}

variable "metadata" {
  type        = map(string)
  description = "Key-value map of additional metadata to assign to the instances"
}
