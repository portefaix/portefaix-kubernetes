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

resource "google_service_account" "vector" {
  account_id   = local.service_name
  display_name = "Vector"
  description  = "Created by Terraform"
}

resource "google_storage_bucket" "vector" {
  name          = local.service_name
  location      = var.bucket_location
  storage_class = var.bucket_storage_class
  labels        = var.bucket_labels

  encryption {
    default_kms_key_name = google_kms_crypto_key.vector.id
  }

  # Ensure the KMS crypto-key IAM binding for the service account exists prior to the
  # bucket attempting to utilise the crypto-key.
  depends_on = [google_kms_crypto_key_iam_binding.binding]
}

resource "google_storage_bucket_iam_member" "vector" {
  bucket = google_storage_bucket.vector.name
  role   = "roles/storage.objectAdmin"
  member = format("serviceAccount:%s", google_service_account.vector.email)
}

resource "google_service_account_iam_member" "vector" {
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.vector.name
  member             = format("serviceAccount:%s.svc.id.goog[%s/%s]", var.project, var.namespace, var.service_account)
}
