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
#
# SPDX-License-Identifier: Apache-2.0

GCP_PROJECT_dev = portefaix-dev

GCP_REGION_dev = europe-west1-c

CLUSTER_dev = portefaix-dev-cluster-gke

KUBE_CONTEXT_dev = gke_portefaix-dev_europe-west1-c_portefaix-dev-cluster-gke

# SOPS_PROVIDER_dev = gcp-kms
# SOPS_KEY_dev = projects/portefaix-dev/locations/europe-west1/keyRings/portefaix-dev-sops/cryptoKeys/portefaix-dev-sops
SOPS_PROVIDER_dev = age
SOPS_KEY_dev = age177h9wx48t7cu3ycnyf6qzjavwlsdwclz4wj7n8u8uj7k8tthjv8q00kggc
SOPS_AGE_KEY_FILE_dev = .secrets/gcp/dev/age/age.agekey

GCP_BASTION_dev = portefaix-dev-bastion
GCP_BASTION_ZONE_dev = europe-west1-c

GCP_SECRET_LOCATIONS_dev = europe-west1
