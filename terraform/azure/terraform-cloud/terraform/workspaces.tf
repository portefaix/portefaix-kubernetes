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

resource "tfe_workspace" "aws" {
  for_each = var.workspaces

  name              = each.key
  organization      = data.tfe_organization.portefaix.name
  description       = format("The %s workspace", each.key)
  working_directory = each.value.directory

  vcs_repo {
    identifier     = format("%s/%s", var.gh_organization, var.gh_repo)
    branch         = each.value.branch
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }

  queue_all_runs      = false
  global_remote_state = true
  trigger_prefixes    = each.value.trigger
  allow_destroy_plan  = true

  tag_names = each.value.tags
}

resource "tfe_variable" "arm_subscription_id" {
  for_each = tfe_workspace.aws

  key          = "ARM_SUBSCRIPTION_ID"
  value        = var.arm_subscription_id
  category     = "env"
  sensitive    = "true"
  workspace_id = each.value.id
  description  = "ARM Subscription ID"
}

resource "tfe_variable" "arm_client_id" {
  for_each = tfe_workspace.aws

  key          = "ARM_CLIENT_ID"
  value        = var.arm_client_id
  category     = "env"
  sensitive    = "true"
  workspace_id = each.value.id
  description  = "ARM Client ID"
}

resource "tfe_variable" "arm_client_secret" {
  for_each = tfe_workspace.aws

  key          = "ARM_CLIENT_SECRET"
  value        = var.arm_client_secret
  category     = "env"
  sensitive    = "true"
  workspace_id = each.value.id
  description  = "ARM Client Secret"
}

resource "tfe_variable" "arm_tenant_id" {
  for_each = tfe_workspace.aws

  key          = "ARM_TENANT_ID"
  value        = var.arm_tenant_id
  category     = "env"
  sensitive    = "true"
  workspace_id = each.value.id
  description  = "ARM Tenant ID"
}
