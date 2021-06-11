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
DEBUG_COLOR="\e[34m"
OK_COLOR="\e[32m"
ERROR_COLOR="\e[31m"
WARN_COLOR="\e[35m"
INFO_COLOR="\e[36m"

manifests=$1
[ -z "${manifests}" ] && echo -e "${ERROR_COLOR}Manifests not satisfied${NO_COLOR}" && exit 1
clusters=$2
[ -z "${clusters}" ] && echo -e "${ERROR_COLOR}Clusters not satisfied${NO_COLOR}" && exit 1

# mirror kustomize-controller build options
# kustomize_flags="--enable_kyaml=false --allow_id_changes=false --load_restrictor=LoadRestrictionsNone"
kustomize_flags=""
kustomize_config="kustomization.yaml"

find ${manifests} -type f -name '*.yaml' -print0 | while IFS= read -r -d $'\0' file;
  do
    echo -e "${INFO_COLOR} - Validating $file${NO_COLOR}"
    yq e 'true' "$file" > /dev/null
done
find ${clusters} -type f -name '*.yaml' -print0 | while IFS= read -r -d $'\0' file;
  do
    echo -e "${INFO_COLOR} - Validating $file${NO_COLOR}"
    yq e 'true' "$file" > /dev/null
done

echo -e "${INFO_COLOR} - Downloading Flux OpenAPI schemas${NO_COLOR}"
mkdir -p /tmp/flux-crd-schemas/master-standalone-strict
curl -sL https://github.com/fluxcd/flux2/releases/latest/download/crd-schemas.tar.gz | tar zxf - -C /tmp/flux-crd-schemas/master-standalone-strict

echo -e "${INFO_COLOR} - Validating kustomize overlays${NO_COLOR}"
find ${clusters}/overlays -type f -name $kustomize_config -print0 | while IFS= read -r -d $'\0' file;
do
  echo -e "${INFO_COLOR} - Validating kustomization ${file/%$kustomize_config}${NO_COLOR}"
  # kustomize build "${file/%$kustomize_config}" $kustomize_flags | kubeval --ignore-missing-schemas --additional-schema-locations=file:///tmp/flux-crd-schemas
  kustomize build "${file/%$kustomize_config}" $kustomize_flags | kubeconform --ignore-missing-schemas --schema-location=file:///tmp/flux-crd-schemas
  if [[ ${PIPESTATUS[0]} != 0 ]]; then
    exit 1
  fi
done
