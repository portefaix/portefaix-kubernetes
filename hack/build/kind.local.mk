# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

CLUSTER_local = portefaix-local

KUBE_CONTEXT_local = kind-portefaix-local

KEY_NAME="local.kind.portefaix.xyz"
KEY_COMMENT="flux secrets"

SOPS_PROVIDER_local = pgp
SOPS_KEY_local = E9EC435D458F1F9047E4026AFED8DABE8BE15123
