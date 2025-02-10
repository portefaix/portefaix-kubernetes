# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

CLUSTER_homelab = k3s-portefaix-homelab

KUBE_CONTEXT_homelab = k3s-portefaix-homelab

# SOPS_PROVIDER_homelab = pgp
# SOPS_KEY_homelab = 82515583D0225FABE4F4FC7874420B8A43DCF894
SOPS_PROVIDER_homelab = age
SOPS_KEY_homelab = age133ly60ep0tp9vm4t95a6c6wgvv9uqtpzsgwkw8wfneshvank79ysmew3wl
SOPS_AGE_KEY_FILE_homelab = .secrets/k3s/homelab/age/age.agekey

AKEYLESS_PROFILE_homelab = portefaix-homelab

CLOUDFLARE_BUCKET_homelab = portefaix-homelab-tfstates
CLOUDFLARE_ACCOUNT_homelab = $(shell echo ${CLOUDFLARE_ACCOUNT_ID})
