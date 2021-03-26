#!/bin/bash

NO_COLOR="\033[0m"
DEBUG_COLOR="\e[34m"
INFO_COLOR="\e[32m"
ERROR_COLOR="\e[31m"
WARN_COLOR="\e[35m"

ENV=$1
[ -z "${ENV}" ] && echo "Environment not satisfied" && exit 1

KEY_NAME="${ENV}.kind.portefaix.xyz"
KEY_COMMENT="fluxcd secrets"
GPG_DIR=".secrets/kind/${ENV}/gpg"

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

gpg --export --armor gpg "$KEY_FINGERPRINT" > ${GPG_DIR}/sops.pub.asc
gpg --export-secret-keys --armor gpg "$KEY_FINGERPRINT" > ${GPG_DIR}/sops.asc
