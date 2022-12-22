#!/usr/bin/env bash

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

NO_COLOR="\033[0m"
# DEBUG_COLOR="\e[34m"
INFO_COLOR="\e[32m"
# ERROR_COLOR="\e[31m"
# WARN_COLOR="\e[35m"

STEP=${STEP:-step}

CLOUD=$1
[ -z "${CLOUD}" ] && echo "Cloud not satisfied" && exit 1
ENV=$2
[ -z "${ENV}" ] && echo "Environment not satisfied" && exit 1

SECRETS_DIR=".secrets/${CLOUD}/${ENV}/linkerd"
echo -e "${INFO_COLOR}Generate secrets into: ${SECRETS_DIR}${NO_COLOR}"

echo -e "${INFO_COLOR}Trust anchor certificate${NO_COLOR}"
${STEP} certificate create root.linkerd.cluster.local \
    "${SECRETS_DIR}/ca.crt" "${SECRETS_DIR}/ca.key" \
    --profile root-ca --no-password --insecure

echo -e "${INFO_COLOR}Issuer certificate and key${NO_COLOR}"
${STEP} certificate create identity.linkerd.cluster.local \
    "${SECRETS_DIR}/issuer.crt" "${SECRETS_DIR}/issuer.key" \
    --profile intermediate-ca --not-after 8760h --no-password --insecure \
    --ca "${SECRETS_DIR}/ca.crt" --ca-key "${SECRETS_DIR}/ca.key"

crtExpiry=$(date -d '+8760 hour' +"%Y-%m-%dT%H:%M:%SZ")

echo -e "${INFO_COLOR}Create Kubernetes secret${NO_COLOR}"
kubectl --namespace=linkerd create secret generic linkerd-certs \
    --from-literal="crtExpiry=${crtExpiry}" \
    --from-file="${SECRETS_DIR}/ca.crt" \
    --from-file="${SECRETS_DIR}/issuer.crt" \
    --from-file="${SECRETS_DIR}/issuer.key" \
    --dry-run=client -o yaml > secrets.yaml
