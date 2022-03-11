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

module "iap_bastion" {
  source = "../modules/bastion"

  project      = var.project
  region       = var.region
  zone         = var.zone
  network_name = var.network_name

  name         = var.name
  machine_type = var.machine_type
  disk_size_gb = var.disk_size_gb
  disk_type    = var.disk_type
  shielded_vm  = var.shielded_vm

  scopes = var.scopes

  service_account_roles = var.service_account_roles

  members = var.members

  metadata = var.metadata
  tags     = var.tags
  labels   = var.labels
}
