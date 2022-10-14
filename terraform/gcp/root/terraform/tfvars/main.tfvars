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

region = "europe-west1"

#############################################################################
# Organization

organization_name = "portefaix"

policy_domains_to_allow = ["portefaix.xyz"]

core_environments = ["dev"] #, "staging", "prod"]

group_org_admins      = "portefaix-organization-admins@portefaix.xyz"
group_billing_admins  = "portefaix-billing-admins@portefaix.xyz"
group_audit_admins    = "portefaix-audit-admins@portefaix.xyz"
group_security_admins = "portefaix-security-admins@portefaix.xyz"

# default_region       = "europe-west1"

core_network_name = "portefaix-core"

subnets = {
  prod = [
    {
      subnet_name           = "portefaix-core-prod"
      subnet_ip             = "10.20.0.0/20"
      subnet_region         = "europe-west1"
      subnet_private_access = true
      subnet_flow_logs      = true
    }
  ],
  staging = [
    {
      subnet_name           = "portefaix-core-staging"
      subnet_ip             = "10.21.0.0/20"
      subnet_region         = "europe-west1"
      subnet_private_access = true
      subnet_flow_logs      = true
    }
  ],
  dev = [
    {
      subnet_name           = "portefaix-core-dev"
      subnet_ip             = "10.22.0.0/20"
      subnet_region         = "europe-west1"
      subnet_private_access = true
      subnet_flow_logs      = true
    }
  ],
}

secondary_ranges = {
  prod = {
    portefaix-core-prod = [
      {
        range_name    = "portefaix-prod-gke-services"
        ip_cidr_range = "10.50.16.0/20"
      },
      {
        range_name    = "portefaix-prod-gke-pods"
        ip_cidr_range = "10.50.32.0/20"
      },
    ]
  },
  staging = {
    portefaix-core-staging = [
      {
        range_name    = "portefaix-staging-gke-services"
        ip_cidr_range = "10.51.16.0/20"
      },
      {
        range_name    = "portefaix-staging-gke-pods"
        ip_cidr_range = "10.51.32.0/20"
      },
    ]
  }
  dev = {
    portefaix-core-dev = [
      {
        range_name    = "portefaix-dev-gke-services"
        ip_cidr_range = "10.52.16.0/20"
      },
      {
        range_name    = "portefaix-dev-gke-pods"
        ip_cidr_range = "10.52.32.0/20"
      },
    ]
  }
}

# subnets = [
#   {
#     subnet_name   = "portefaix-core-prod"
#     subnet_ip     = "10.10.0.0/20"
#     subnet_region = "europe-west1"
#     subnet_private_access = true
#     subnet_flow_logs      = true
#   },
#   {
#     subnet_name           = "portefaix-core-staging"
#     subnet_ip             = "10.11.0.0/20"
#     subnet_region         = "europe-west1"
#     subnet_private_access = true
#     subnet_flow_logs      = true
#   },
#   {
#     subnet_name           = "portefaix-core-dev"
#     subnet_ip             = "10.12.0.0/20"
#     subnet_region         = "europe-west1"
#     subnet_private_access = true
#     subnet_flow_logs      = true
#   },
# ]

# secondary_ranges = {
#   portefaix-core-prod = [
#     {
#       range_name    = "portefaix-dev-gke-services"
#       ip_cidr_range = "10.40.16.0/20"
#     },
#     {
#       range_name    = "portefaix-dev-gke-pods"
#       ip_cidr_range = "10.40.32.0/20"
#     },
#   ],
#   portefaix-core-staging = [
#     {
#       range_name    = "portefaix-dev-gke-services"
#       ip_cidr_range = "10.41.16.0/20"
#     },
#     {
#       range_name    = "portefaix-dev-gke-pods"
#       ip_cidr_range = "10.41.32.0/20"
#     },
#   ],
#   portefaix-core-dev = [
#     {
#       range_name    = "portefaix-dev-gke-services"
#       ip_cidr_range = "10.42.16.0/20"
#     },
#     {
#       range_name    = "portefaix-dev-gke-pods"
#       ip_cidr_range = "10.42.32.0/20"
#     },
#   ]
# }

budget_topic_name = "budget"
# network_alert_pubsub_topic = "projects/{project_id}/topics/{topic_id}"
