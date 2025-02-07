# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
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
