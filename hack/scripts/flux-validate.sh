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


function openapi_generation_tool {
  pushd /tmp/ > /dev/null
  echo -e "${OK_COLOR}Download OpenAPI generation tool${NO_COLOR}"
  rm -f openapi2jsonschema.py
  curl -sLO https://raw.githubusercontent.com/yannh/kubeconform/v0.4.8/scripts/openapi2jsonschema.py
  chmod +x openapi2jsonschema.py
  popd > /dev/null
}

function openapi_commons {
  name=$1
  url=$2
  crds=$3

  pushd /tmp/ > /dev/null
  echo -e "${OK_COLOR}Generate OpenAPI schemas: ${name}${NO_COLOR}"
  rm -fr "${name}"
  git clone "${url}"
  cd "${name}"
  export FILENAME_FORMAT='{kind}-{group}-{version}'
  # shellcheck disable=SC2086
  /tmp/openapi2jsonschema.py ${crds}
  popd > /dev/null
}

function openapi_fluxcd {
  pushd /tmp/ > /dev/null
  echo -e "${OK_COLOR}Download OpenAPI schemas: FluxCD${NO_COLOR}"
  mkdir -p flux-crd-schemas/master-standalone-strict
  curl -sL https://github.com/fluxcd/flux2/releases/latest/download/crd-schemas.tar.gz | tar zxf - -C flux-crd-schemas/master-standalone-strict
  popd > /dev/null
}

function openapi_prometheus_operator {
  pushd /tmp/ > /dev/null
  echo -e "${OK_COLOR}Generate OpenAPI schemas: Prometheus Operator${NO_COLOR}"
  rm -fr kube-prometheus
  git clone https://github.com/prometheus-operator/kube-prometheus
  cd kube-prometheus
  jb install
  ./scripts/generate-schemas.sh
  popd > /dev/null
}

function openapi_kyverno {
  openapi_commons "kyverno" "https://github.com/kyverno/kyverno.git" "config/crds/*.yaml"
}

function openapi_aws_alb {
  openapi_commons "aws-load-balancer-controller" "https://github.com/kubernetes-sigs/aws-load-balancer-controller" "helm/aws-load-balancer-controller/crds/*.yaml"
}

function validate_yaml {
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
}

function validate_manifests {
  echo -e "${OK_COLOR}Kubernetes validation${NO_COLOR}"
  kubeconform -strict -verbose -summary \
    -schema-location default \
    -schema-location="/tmp/flux-crd-schemas/master-standalone-strict/{{ .ResourceKind }}{{ .KindSuffix }}.json" \
    -schema-location="/tmp/kube-prometheus/crdschemas/{{ .ResourceKind }}.json" \
    -schema-location="/tmp/kyverno/{{ .ResourceKind }}{{ .KindSuffix }}.json" \
    -schema-location="/tmp/aws-load-balancer-controller/{{ .ResourceKind }}{{ .KindSuffix }}.json" \
    "${manifests}/base"
}

function informations {
  echo -e "${OK_COLOR}Informations${NO_COLOR}"
  kubectl version --client
  kustomize version
  yq --version
}

informations
openapi_generation_tool
openapi_fluxcd
openapi_prometheus_operator
openapi_kyverno
openapi_aws_alb

validate_yaml
validate_manifests
