#!/bin/bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

NO_COLOR="\033[0m"
# DEBUG_COLOR="\e[34m"
INFO_COLOR="\e[32m"
# ERROR_COLOR="\e[31m"
# WARN_COLOR="\e[35m"

TYPE=$1
[ -z "${TYPE}" ] && echo "Type not satisfied" && exit 1
ENV=$2
[ -z "${ENV}" ] && echo "Environment not satisfied" && exit 1

KEY_NAME="${ENV}.${TYPE}.portefaix.xyz"
KEY_COMMENT="fluxcd secrets"
GPG_DIR=".secrets/${TYPE}/${ENV}/gpg"

gpg --batch --full-generate-key <<EOF
%no-protection
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Expire-Date: 0
Name-Comment: ${KEY_COMMENT}
Name-Real: ${KEY_NAME}
EOF

KEY_FINGERPRINT=$(gpg --list-secret-keys --with-colons "$KEY_NAME" | grep '^fpr:' | cut -d':' -f10 | head -n1)

echo -e "${INFO_COLOR}Fingerprint:${NO_COLOR} $KEY_FINGERPRINT"

mkdir -p "${GPG_DIR}"
gpg --export --armor gpg "$KEY_FINGERPRINT" >"${GPG_DIR}/sops.pub.asc"
gpg --export-secret-keys --armor gpg "$KEY_FINGERPRINT" >"${GPG_DIR}/sops.asc"
