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

# Prerequisites
# - yq v4.6
# - kustomize v3.9
# - kubeval v0.15

# set -o errexit
set -euo pipefail

NO_COLOR="\033[0m"
DEBUG_COLOR="\e[34m"
# OK_COLOR="\e[32m"
# ERROR_COLOR="\e[31m"
# WARN_COLOR="\e[35m"
INFO_COLOR="\e[36m"

reset_color="\\e[0m"
color_red="\\e[31m"
color_green="\\e[32m"
color_blue="\\e[36m"

KUBECONFORM_VERSION=v0.6.7

# SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}\uf120 $*${reset_color}"; }
function echo_debug { echo -e "${DEBUG_COLOR}\uf120 $*${reset_color}"; }

function validate_argo_cd_manifests {
    for values in $(find . -name "values-**.yaml"); do
        rm -fr charts Chart.lock
        echo_debug "[helm] Update dependencies"
        helm dependency build >&2 >/dev/null
        echo_debug "[kubeconform] Validate manifests for ${values}"
        helm template portefaix-test . -f values.yaml -f "${values}" 2>/tmp/kubeconform | kubeconform -schema-location default -schema-location 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json' -ignore-missing-schemas -strict -exit-on-error -skip CiliumNetworkPolicy,CiliumClusterwideNetworkPolicy
        rm -f manifests.yaml
    done
}

if [ $# -lt 1 ]; then
    echo_fail "Usage: $0 <gitops> <args>"
    echo_info "Argo-CD: $0 argocd <cloud> <environment>"
    # echo_info "FluxCD: $0 fluxcd <clusters> <manifests>"
    exit 1
fi

gitops=$1
[ -z "${gitops}" ] && echo_fail "Choice not satisfied" && exit 1

case ${gitops} in
    # "fluxcd")
    #     clusters=$2
    #     [ -z "${clusters}" ] && echo_fail "Clusters not satisfied" && exit 1
    #     manifests=$3
    #     [ -z "${manifests}" ] && echo_fail "Manifests not satisfied" && exit 1
    #     # init
    #     # validate_yaml "${clusters}"
    #     # validate_yaml "${manifests}"
    #     # validate_fluxcd_manifests
    #     echo_success "FluxCD"
    #     ;;
    # "argocd")
    #     manifests=$2
    #     [ -z "${manifests}" ] && echo_fail "Manifests not satisfied" && exit 1
    #     init
    #     validate_yaml ${manifests}
    #     validate_argocd_manifests "${manifests}"
    #     echo_success "Argo-CD"
    #     ;;
    "argocd")
        # cloud=$2
        # [ -z "${cloud}" ] && echo_fail "Cloud not satisfied" && exit 1
        # environment=$3
        # [ -z "${environment}" ] && echo_fail "Environment not satisfied" && exit 1
        echo_info "[argo-cd] Validation of Kubernetes manifests"
        pushd gitops/argocd >/dev/null
        
        # for app in $(ls apps); do
        #     echo_info "[argo-cd] Check application: ${app}"
        #     pushd "apps/${app}" >/dev/null
        #     validate_argo_cd_manifests
        #     popd >/dev/null
        # done

        for chart in $(find charts -name Chart.yaml); do
            chart_path=$(dirname ${chart})
            dir=$(basename ${chart_path})
            echo_info "[argo-cd] Check application: ${chart_path}"
            pushd "${chart_path}" >/dev/null
            validate_argo_cd_manifests
            popd >/dev/null
        done

        popd >/dev/null
        ;;
    *)
        echo_fail "Invalid choice. Must be fluxcd or argocd"
        exit 1
        ;;
esac
