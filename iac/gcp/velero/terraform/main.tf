# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

resource "google_service_account" "velero" {
  account_id   = var.account_id
  display_name = var.display_name
  description  = "Created by Terraform"
}

resource "google_storage_bucket" "velero" {
  default_event_based_hold = "false"
  force_destroy            = "false"
  location                 = var.bucket_location
  name                     = format("%s_velero", var.project)
  project                  = var.project
  requester_pays           = "false"
  storage_class            = var.bucket_storage_class
  labels                   = var.bucket_labels
}

resource "google_storage_bucket_iam_member" "velero" {
  bucket = google_storage_bucket.velero.name
  role   = "roles/storage.objectAdmin"
  member = format("serviceAccount:%s", google_service_account.velero.email)
}

resource "google_service_account_iam_member" "velero" {
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.velero.name
  member             = format("serviceAccount:%s.svc.id.goog[%s/%s]", var.project, var.namespace, var.service_account)
}
