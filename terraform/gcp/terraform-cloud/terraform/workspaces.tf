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

resource "tfe_workspace" "gcp" {
  for_each = var.workspaces

  name              = each.key
  organization      = data.tfe_organization.portefaix.name
  description       = format("The %s workspace", each.key)
  working_directory = each.value.directory

  dynamic "vcs_repo" {
    for_each = each.value.gitops ? [{ "branch" = each.value.branch }] : []
    content {
      identifier     = format("%s/%s", var.gh_organization, var.gh_repo)
      branch         = vcs_repo.value.branch
      oauth_token_id = tfe_oauth_client.github.oauth_token_id
    }
  }

  queue_all_runs      = false
  global_remote_state = true
  trigger_prefixes    = each.value.trigger
  allow_destroy_plan  = true
  execution_mode      = each.value.execution_mode
  auto_apply          = each.value.auto_apply

  tag_names = each.value.tags
}


resource "tfe_variable" "gcp_credentials" {
  for_each = tfe_workspace.gcp

  key          = "GOOGLE_CREDENTIALS"
  value        = var.credentials
  category     = "env"
  sensitive    = "true"
  workspace_id = each.value.id
  description  = "The GCP credentials"
}

resource "tfe_variable" "gke_master_authorized_networks" {
  key      = "TF_VAR_master_authorized_networks"
  value    = var.master_authorized_networks
  category = "env"
  # sensitive    = "true"
  workspace_id = tfe_workspace.gcp["portefaix-gcp-dev-gke"].id
  description  = "The GCP credentials"
}

resource "tfe_variable" "portefaix_version" {
  key          = "TF_VAR_portefaix_version"
  value        = var.portefaix_version
  category     = "env"
  sensitive    = "true"
  workspace_id = tfe_workspace.gcp[format("portefaix-gcp-%s-secrets", var.workspace_environment)].id
  description  = "Portefaix version"
}
