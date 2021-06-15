#!/bin/bash

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
gpg --export --armor gpg "$KEY_FINGERPRINT" > "${GPG_DIR}/sops.pub.asc"
gpg --export-secret-keys --armor gpg "$KEY_FINGERPRINT" > "${GPG_DIR}/sops.asc"
