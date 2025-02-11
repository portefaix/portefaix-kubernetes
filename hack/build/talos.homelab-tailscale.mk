# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

CLUSTER_homelab-tailscale = portefaix-talos-homelab

KUBE_CONTEXT_homelab-tailscale = admin@portefaix-talos-homelab-tailscale

AKEYLESS_PROFILE_homelab-tailscale = portefaix-homelab

CLOUDFLARE_BUCKET_homelab = portefaix-talos-tfstates
CLOUDFLARE_ACCOUNT_homelab = $(shell echo ${CLOUDFLARE_ACCOUNT_ID})
