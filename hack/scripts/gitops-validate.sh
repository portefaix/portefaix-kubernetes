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
# OK_COLOR="\e[32m"
# ERROR_COLOR="\e[31m"
# WARN_COLOR="\e[35m"
INFO_COLOR="\e[36m"

reset_color="\\e[0m"
color_red="\\e[31m"
color_green="\\e[32m"
color_blue="\\e[36m";

# SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}\uf120 $*${reset_color}"; }

function openapi_generation_tool {
    pushd /tmp/ > /dev/null
    echo_info "Download OpenAPI generation tool"
    rm -f openapi2jsonschema.py
    curl -sLO https://raw.githubusercontent.com/yannh/kubeconform/v0.4.8/scripts/openapi2jsonschema.py
    chmod +x openapi2jsonschema.py
    popd > /dev/null
}

function openapi_commons {
    name=$1
    url=$2
    version=$3
    crds=$4

    pushd /tmp/ > /dev/null
    echo_info "Generate OpenAPI schemas: ${name}"
    rm -fr "${name}"
    git clone "${url}"
    cd "${name}"
    git checkout "${version}"
    export FILENAME_FORMAT='{kind}-{group}-{version}'
    # shellcheck disable=SC2086
    /tmp/openapi2jsonschema.py ${crds}
    popd > /dev/null
}

function openapi_fluxcd {
    pushd /tmp/ > /dev/null
    echo_info "Download OpenAPI schemas: FluxCD"
    mkdir -p flux-crd-schemas/master-standalone-strict
    curl -sL https://github.com/fluxcd/flux2/releases/latest/download/crd-schemas.tar.gz | tar zxf - -C flux-crd-schemas/master-standalone-strict
    popd > /dev/null
}

function openapi_prometheus_operator {
    pushd /tmp/ > /dev/null
    echo_info "Generate OpenAPI schemas: Prometheus Operator"
    rm -fr kube-prometheus
    git clone https://github.com/prometheus-operator/kube-prometheus
    cd kube-prometheus
    jb install
    ./scripts/generate-schemas.sh
    popd > /dev/null
}

function openapi_kyverno {
    openapi_commons "kyverno" "https://github.com/kyverno/kyverno.git" "v1.6.0" "config/crds/*.yaml"
}

function openapi_aws_alb {
    openapi_commons "aws-load-balancer-controller" "https://github.com/kubernetes-sigs/aws-load-balancer-controller" "v2.3.1" "helm/aws-load-balancer-controller/crds/*.yaml"
}

function openapi_apigateway {
    # GKE supports only v0.3.0 https://cloud.google.com/kubernetes-engine/docs/how-to/deploying-gateways#install_gateway_api_crds
    openapi_commons "gateway-api" "https://github.com/kubernetes-sigs/gateway-api.git" "v0.3.0" "config/crd/bases/*.yaml"
}

function validate_yaml {
    echo_info "YAML validation"
    local dir=$1

    find "${dir}" -type f -name '*.yaml' -print0 | while IFS= read -r -d $'\0' file;
    do
        if [[ ! "${file}" =~ .*"templates".* ]]; then
            echo -e "${INFO_COLOR}- $file${NO_COLOR}"
            yq e 'true' "$file" > /dev/null
        fi
    done
}

function validate_fluxcd_manifests {
    echo_info "Kubernetes validation"
    kubeconform -strict -summary \
        -schema-location default \
        -schema-location="/tmp/flux-crd-schemas/master-standalone-strict/{{ .ResourceKind }}{{ .KindSuffix }}.json" \
        -schema-location="/tmp/kube-prometheus/crdschemas/{{ .ResourceKind }}.json" \
        -schema-location="/tmp/kyverno/{{ .ResourceKind }}{{ .KindSuffix }}.json" \
        -schema-location="/tmp/aws-load-balancer-controller/{{ .ResourceKind }}{{ .KindSuffix }}.json" \
        -schema-location="/tmp/gateway-api/{{ .ResourceKind }}{{ .KindSuffix }}.json" \
        "${manifests}/base"
}

function validate_argocd_manifests {
    local dir=$1

    # echo_info "Kustomization validation"
    # for cloud in $(ls "${dir}/apps"); do
    #     for env in $(ls "${dir}/apps/${cloud}"); do
    #         for stack in $(ls "${dir}/apps/${cloud}/${env}"); do
    #             echo "- ${cloud}/${env}/${stack}"
    #             kustomize build "${dir}/apps/${cloud}/${env}/${stack}" > /dev/null
    #         done
    #     done
    # done

    echo_info "Helm validation for Stacks"
    pushd "${dir}/stacks" > /dev/null
    # for values in values-*.yaml; do
    for values in $(find . -name "values-**.yaml"); do
		# rm -fr charts Chart.lock
		# helm dependency build >&2
        echo "- ${values}"
		helm template portefaix-app . -f values.yaml -f "${values}" --debug > /dev/null
    done
    popd > /dev/null

    echo_info "Helm validation for Charts"
    for namespace in $(ls "${dir}/charts"); do
        for chart in $(ls "${dir}/charts/${namespace}"); do
            pushd "${dir}/charts/${namespace}/${chart}" > /dev/null
            for values in $(find . -name "values-**.yaml"); do
                echo "- ${namespace} / ${chart} / ${values}"
                rm -fr charts Chart.lock
                helm dependency build > /dev/null
                helm template portefaix-app . -f values.yaml -f "${values}" --api-versions=monitoring.coreos.com/v1 --debug > /dev/null
                rm -fr charts Chart.lock
            done
            popd > /dev/null
        done
    done
}

function informations {
    echo_info "Informations"
    kubectl version --client
    kustomize version
    yq --version
}

function init {
    informations
    openapi_generation_tool
    openapi_fluxcd
    openapi_prometheus_operator
    openapi_kyverno
    openapi_aws_alb
    openapi_apigateway
}

if [ $# -lt 1 ]; then
    echo_fail "Usage: $0 <gitops> <args>"
    echo_info "FluxCD: $0 fluxcd <clusters> <manifests>"
    echo_info "Argo-CD: $0 argocd "
    exit 1
fi

gitops=$1
[ -z "${gitops}" ] && echo_fail "Choice not satisfied" && exit 1

case ${gitops} in
    "fluxcd")
        clusters=$2
        [ -z "${clusters}" ] && echo_fail "Clusters not satisfied" && exit 1
        manifests=$3
        [ -z "${manifests}" ] && echo_fail "Manifests not satisfied" && exit 1
        init
        validate_yaml "${clusters}"
        validate_yaml "${manifests}"
        validate_fluxcd_manifests
        echo_success "FluxCD"
        ;;
    "argocd")
        manifests=$2
        [ -z "${manifests}" ] && echo_fail "Manifests not satisfied" && exit 1
        # init
        # validate_yaml ${manifests}
        validate_argocd_manifests "${manifests}"
        echo_success "Argo-CD"
        ;;
    *)
        echo_fail "Invalid choice. Must be fluxcd or argocd"
        exit 1
        ;;
esac
