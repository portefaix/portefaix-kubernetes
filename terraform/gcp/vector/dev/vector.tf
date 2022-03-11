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

module "vector" {
  source = "../modules/vector"

  project = var.project

  bucket_location      = var.bucket_location
  bucket_storage_class = var.bucket_storage_class
  bucket_labels        = var.bucket_labels

  namespace       = var.namespace
  service_account = var.service_account

  enable_kms       = var.enable_kms
  keyring_location = var.keyring_location
}
