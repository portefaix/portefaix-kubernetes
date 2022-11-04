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

resource "tfe_workspace" "aws" {
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

resource "tfe_variable" "aws_acces_key" {
  for_each = tfe_workspace.aws

  key          = "AWS_ACCESS_KEY_ID"
  value        = var.access_key
  category     = "env"
  sensitive    = "true"
  workspace_id = each.value.id
  description  = "The AWS access key"
}

resource "tfe_variable" "aws_secret_key" {
  for_each = tfe_workspace.aws

  key          = "AWS_SECRET_ACCESS_KEY"
  value        = var.secret_key
  category     = "env"
  sensitive    = "true"
  workspace_id = each.value.id
  description  = "The AWS secret key"
}

resource "tfe_variable" "slack_webhook_url" {
  key          = "TF_VAR_slack_webhook_url"
  value        = var.slack_webhook_url
  category     = "env"
  sensitive    = "true"
  workspace_id = tfe_workspace.aws[format("portefaix-aws-%s-notifications", var.workspace_environment)].id
  description  = "Slack webhook URL for notifications"
}

resource "tfe_variable" "portefaix_version" {
  key          = "TF_VAR_portefaix_version"
  value        = var.portefaix_version
  category     = "env"
  sensitive    = "true"
  workspace_id = tfe_workspace.aws[format("portefaix-aws-%s-secrets", var.workspace_environment)].id
  description  = "Portefaix version"
}

resource "tfe_variable" "org_email" {
  for_each = toset([
    "portefaix-aws-orga-security-hub"
  ])

  key          = "TF_VAR_org_email"
  value        = var.org_email
  category     = "env"
  sensitive    = "true"
  workspace_id = tfe_workspace.aws[each.value].id
  description  = "Organization email"
}

resource "tfe_variable" "org_email_domain" {
  for_each = toset([
    "portefaix-aws-orga-security-hub"
  ])

  key          = "TF_VAR_org_email_domain"
  value        = var.org_email_domain
  category     = "env"
  sensitive    = "true"
  workspace_id = tfe_workspace.aws[each.value].id
  description  = "Organization email domain"
}
