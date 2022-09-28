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
  description = "The location linked to the project"
}

#############################################################################
# Organization

variable "organization_id" {
  description = "GCP Organization ID"
  type        = string
}

variable "organization_name" {
  description = "GCP Organization name"
  type        = string
}

variable "core_environments" {
  description = "List of Core environments"
  type = list(string)
}

variable "default_region" {
  type        = string
  description = "The location linked to the project"
  default = "europe-west1"
}

variable "billing_account" {
  description = "The ID of the billing account to associate projects with."
  type        = string
}

variable "group_org_admins" {
  description = "Google Group for GCP Organization Administrators"
  type        = string
}

variable "group_billing_admins" {
  description = "Google Group for GCP Billing Administrators"
  type        = string
}

variable "group_audit_admins" {
  description = "Google Group for GCP Audit Administrators"
  type        = string
}

variable "group_security_admins" {
  description = "Google Group for GCP Security Administrators"
  type        = string
}

variable "essential_contacts_language" {
  description = "Essential Contacts preferred language for notifications, as a ISO 639-1 language code. See [Supported languages](https://cloud.google.com/resource-manager/docs/managing-notification-contacts#supported-languages) for a list of supported languages."
  type        = string
  default     = "en"
}

variable "sa_org_iam_permissions" {
  description = "List of permissions granted to Terraform service account across the GCP organization."
  type        = list(string)
  default = [
    "roles/billing.user",
    "roles/compute.networkAdmin",
    "roles/compute.xpnAdmin",
    "roles/iam.securityAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/logging.configWriter",
    "roles/orgpolicy.policyAdmin",
    "roles/resourcemanager.folderAdmin",
    "roles/resourcemanager.organizationViewer",
  ]
}

variable "sa_enable_impersonation" {
  description = "Allow org_admins group to impersonate service account & enable APIs required."
  type        = bool
  default     = true
}

variable "tf_service_account_id" {
  description = "ID of service account for terraform in seed project"
  type        = string
  default     = "org-terraform"
}

variable "tf_service_account_name" {
  description = "Display name of service account for terraform in seed project"
  type        = string
  default     = "Portefaix Organization Terraform Account"
}

# variable "groups" {
#   description = "Contain the details of the Groups to be created."
#   type = object({
#     create_groups   = bool
#     billing_project = string
#     required_groups = object({
#       group_org_admins           = string
#       group_billing_admins       = string
#       group_audit_admins         = string
#       group_security_admins           = string
#       group_network_admins = string
#       group_developers = string
#       group_devops = string
#     })
#     optional_groups = object({
#       group_logging_admins      = string
#       group_monitoring_admins    = string
#     })
#   })
#   default = {
#     create_groups   = true
#     billing_project = ""
#     required_groups = {
#       group_org_admins           = "portefaix-organization-admins@portefaix.xyz"
#       group_billing_admins       = "portefaix-billing-admins@portefaix.xyz"
#       group_audit_admins           = "portefaix-audit-admins@portefaix.xyz"
#       group_security_admins = "portefaix-security-admins@portefaix.xyz"
#       group_network_admins = "portefaix-network-admins@portefaix.xyz"
#       group_developers = "portefaix-developers-admins@portefaix.xyz"
#       group_devops = "portefaix-devops-admins@portefaix.xyz"
#     }
#     optional_groups = {
#       group_logging_admins = "portefaix-logging-admins@portefaix.xyz"
#       group_monitoring_admins = "portefaix-monitoring-admins@portefaix.xyz"
#     }
#   }
# }

# variable "initial_group_config" {
#   description = "Define the group configuration when it are initialized. Valid values are: WITH_INITIAL_OWNER, EMPTY and INITIAL_GROUP_CONFIG_UNSPECIFIED."
#   type        = string
#   default     = "WITH_INITIAL_OWNER"
# }

#############################################################################
# Network

variable "core_network_name" {
  description = "Name for the Core Shared VPC"
  type = string
}

variable "subnets" {
  type        = map(list(map(string)))
  description = "The list of subnets being created"
}

variable "secondary_ranges" {
  type = map(map(list(object({
    range_name    = string,
    ip_cidr_range = string
  }))))
  description = "Secondary ranges"
}

# variable "subnets" {
#   type        = list(map(string))
#   description = "The list of subnets being created"
# }

# variable "secondary_ranges" {
#   type = map(list(object({
#     range_name    = string,
#     ip_cidr_range = string
#   })))
#   description = "Secondary ranges"
# }

variable "default_network_tier" {
  description = "Default Network Service Tier for resources created in this project. If unset, the value will not be modified. See https://cloud.google.com/network-tiers/docs/using-network-service-tiers and https://cloud.google.com/network-tiers."
  type        = string
  default     = ""
}

variable "network_budget_amount" {
  description = "The amount to use for the budget"
  default     = 10
  type        = number
}

variable "network_budget_alert_spent_percents" {
  description = "The list of percentages of the budget to alert on"
  type        = list(number)
  default     = [0.7, 0.8, 0.9, 1.0]
}

variable "network_budget_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}`"
  type        = string
  default     = null
}

#############################################################################
# Logging

variable "logging_budget_amount" {
  description = "The amount to use for the budget"
  default     = 10
  type        = number
}

variable "logging_budget_alert_spent_percents" {
  description = "The list of percentages of the budget to alert on"
  type        = list(number)
  default     = [0.7, 0.8, 0.9, 1.0]
}

variable "logging_budget_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the logging project"
  type        = string
  default     = null
}

#############################################################################
# Policies

variable "policy_domains_to_allow" {
  description = "Organization policy for allowed domain"
  type = list(string)
}

variable "vms_to_allow" {
  description = "The list of VMs are allowed to use external IP, every element of the list must be identified by the VM instance name, in the form: projects/PROJECT_ID/zones/ZONE/instances/INSTANCE"
  type        = list(string)
  default     = []
}

#############################################################################
# Commons

variable "budget_topic_name" {
  type        = string
  description = "The Pub/Sub topic name for budget"
}

variable "labels" {
  description = "Labels to apply to the project."
  type        = map(string)
  default     = {
    project     = "portefaix"
  }
}