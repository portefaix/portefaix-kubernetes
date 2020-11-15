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

output "bucket" {
  description = "Bucket resource (for single use)."
  value       = google_storage_bucket.velero
}

output "name" {
  description = "Bucket name (for single use)."
  value       = google_storage_bucket.velero.name
}

output "url" {
  description = "Bucket URL (for single use)."
  value       = google_storage_bucket.velero.url
}

