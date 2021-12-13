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

reset_color="\\e[0m"
color_red="\\e[31m"
color_green="\\e[32m"
color_blue="\\e[36m";

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}$*${reset_color}"; }

ARGOCD_VERSION="v2.1.7"
ARGOCD_HELM_VERSION="3.28.1"

function argocd_manifests() {
    local version=$1
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/${ARGOCD_VERSION}/manifests/install.yaml
}

function argocd_helm() {
    local version=$1
    helm repo add argo https://argoproj.github.io/argo-helm
    kubectl create namespace argocd
    helm install argocd argo/argo-cd --namespace argocd --version "${version}" --values "${SCRIPT_DIR}/argocd-values.yaml"
}

choice=$1
[ -z "${choice}" ] && echo_fail "Setup choice not satisfied" && exit 1

case ${choice} in
    manifests)
        argocd_manifests "${ARGOCD_VERSION}"
        ;;
    helm)
        argocd_helm "${ARGOCD_HELM_VERSION}"
        ;;
    *)
        echo_fail "Invalid choice. Must be manifests or helm."
        exit 1
        ;;
esac
