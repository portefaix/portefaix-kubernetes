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

AZ_RESOURCE_GROUP_dev = portefaix-dev-aks

AZ_RESOURCE_GROUP_TAGS_dev = "env=dev project=portefaix made-by=azcli"

AZ_STORAGE_ACCOUNT_dev = portefaixdev

AZ_LOCATION_dev = westeurope

CLUSTER_dev = portefaix-dev-aks

# SOPS_PROVIDER_dev = azure-kv
# SOPS_KEY_dev = https://portefaix-dev-sops-tmp.vault.azure.net/keys/portefaix-dev-sops-tmp/d4da1ad6b9cf474095774d06871c5c1b
SOPS_PROVIDER_dev = age
SOPS_KEY_dev = age1wt7t48m206gv74llh9fs8u4kaapnjzhxydyk3a9mavzkaulsz5nq9qujgc
SOPS_AGE_KEY_FILE_dev = .secrets/azure/dev/age/age.agekey

AZ_SECRET_RESOURCE_GROUP_dev = portefaix-dev #-secrets