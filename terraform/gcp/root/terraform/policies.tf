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

# module "organization_policies_type_boolean" {
#   source           = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
#   version          = "5.2.0"

#   for_each = local.boolean_type_organization_policies

#   # constraint      = "constraints/${each.value}"

#   policy_root_id = var.organization_id
#   policy_root    = "organization"
#   rules = [{
#     enforcement = true
#     allow       = []
#     deny        = []
#     conditions  = []
#   }]
#   constraint  = each.value
#   policy_type = "boolean"
# }


module "org_domain_restricted_sharing" {
  source           = "terraform-google-modules/org-policy/google//modules/domain_restricted_sharing"
  version          = "5.2.0"
  
  organization_id  = var.organization_id
  policy_for       = "organization"
  domains_to_allow = var.policy_domains_to_allow
}

module "skip_default_network" {
  source           = "terraform-google-modules/org-policy/google//modules/skip_default_network"
  version          = "5.2.0"

  policy_for      = "organization"
  organization_id = var.organization_id
}

module "bucket_policy_only" {
  source           = "terraform-google-modules/org-policy/google//modules/bucket_policy_only"
  version          = "5.2.0"

  policy_for      = "organization"
  organization_id = var.organization_id
}

module "restrict_vm_external_ips" {
  source           = "terraform-google-modules/org-policy/google//modules/restrict_vm_external_ips"
  version          = "5.2.0"

  policy_for      = "organization"
  organization_id = var.organization_id
  vms_to_allow    = var.vms_to_allow
}