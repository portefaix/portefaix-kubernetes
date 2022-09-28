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

module "pubsub_budget" {
  source  = "terraform-google-modules/pubsub/google"
  version = "4.0.1"

  project_id = module.shared.project_id
  topic      = format("%s-%s", var.organization_name, var.budget_topic_name)
  topic_labels = merge({
    service = "budget"
    role    = "pubsub"
    environment = "shared"
  }, var.labels)
}

module "network_budget" {
  source  = "terraform-google-modules/project-factory/google//modules/budget"
  version = "13.1.0"

  billing_account = var.billing_account
  projects        = [module.network.project_id]

  amount               = var.network_budget_amount
  alert_spent_percents = var.network_budget_alert_spent_percents
  alert_pubsub_topic   = module.pubsub_budget.id
}