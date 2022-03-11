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

resource "google_artifact_registry_repository" "core" {
  provider = google-beta

  for_each = var.repositories

  repository_id = each.key
  location      = each.value.location
  format        = each.value.format
  description   = "Terraform managed."

  labels = var.labels
}

# resource "google_artifact_registry_repository_iam_member" "gke-sa-pull-container-images" {
#   provider = google-beta

#   for_each = var.repositories

#   location = each.value.location
#   repository = google_artifact_registry_repository.container-images-repo.name
#   role   = "roles/artifactregistry.reader"
#   member = format("serviceAccount:%s", data.google_service_account.gke.email)
# }
