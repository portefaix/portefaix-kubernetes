#!/usr/bin/env bash

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

# Comes from the Flux project.

# This script is meant to be run locally and in CI to validate the Kubernetes
# manifests (including Flux custom resources) before changes are merged into
# the branch synced by Flux in-cluster.

# Prerequisites
# - yq v4.6
# - kustomize v3.9
# - kubeval v0.15

# set -o errexit
set -euo pipefail

NO_COLOR="\033[0m"
# DEBUG_COLOR="\e[34m"
OK_COLOR="\e[32m"
ERROR_COLOR="\e[31m"
# WARN_COLOR="\e[35m"
INFO_COLOR="\e[36m"

clusters=$1
[ -z "${clusters}" ] && echo -e "${ERROR_COLOR}Clusters not satisfied${NO_COLOR}" && exit 1
manifests=$2
[ -z "${manifests}" ] && echo -e "${ERROR_COLOR}Manifests not satisfied${NO_COLOR}" && exit 1

echo -e "${OK_COLOR}YAML validation${NO_COLOR}"
find "${manifests}" -type f -name '*.yaml' -print0 | while IFS= read -r -d $'\0' file;
  do
    echo -e "${INFO_COLOR}- $file${NO_COLOR}"
    yq e 'true' "$file" > /dev/null
done
find "${clusters}" -type f -name '*.yaml' -print0 | while IFS= read -r -d $'\0' file;
  do
    echo -e "${INFO_COLOR}- $file${NO_COLOR}"
    yq e 'true' "$file" > /dev/null
done

echo -e "${OK_COLOR}Downloading Flux OpenAPI schemas${NO_COLOR}"
mkdir -p /tmp/flux-crd-schemas/master-standalone-strict
curl -sL https://github.com/fluxcd/flux2/releases/latest/download/crd-schemas.tar.gz | tar zxf - -C /tmp/flux-crd-schemas/master-standalone-strict

echo -e "${OK_COLOR}Kubernetes validation${NO_COLOR}"
kubeconform -strict -summary \
  -schema-location default \
  -schema-location="/tmp/flux-crd-schemas/master-standalone-strict/{{ .ResourceKind }}{{ .KindSuffix }}.json" \
  "${manifests}/base"
