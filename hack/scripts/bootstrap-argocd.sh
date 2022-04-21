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

reset_color="\\e[0m"
color_red="\\e[31m"
color_green="\\e[32m"
color_blue="\\e[36m";

# SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}\uf120 $*${reset_color}"; }

GITOPS_ARGOCD="./gitops/argocd"
BOOTSTRAP_DIR="${GITOPS_ARGOCD}/bootstrap"
SECRETS_HOME=".secrets"

ARGOCD_NAMESPACE="argocd"
# ARGOCD_VERSION="v4.2.1"

CLOUD=$1
[ -z "${CLOUD}" ] && echo_fail "Cloud provider not satisfied" && exit 1
echo_info "Cloud provider : ${CLOUD}"

ENV=$2
[ -z "${ENV}" ] && echo_fail "Environment not satisfied" && exit 1
ENV="${ENV//-tailscale/}"
echo_info "Environment    : ${ENV}"

choice=$3
[ -z "${choice}" ] && echo_fail "Setup choice not satisfied" && exit 1


function argocd_manifests() {
    local version=$1

    kubectl create namespace "${ARGOCD_NAMESPACE}"
    kubectl apply -n "${ARGOCD_NAMESPACE}" -f "https://raw.githubusercontent.com/argoproj/argo-cd/${version}/manifests/install.yaml"
}

function helm_install() {
    local chart_name=$1

    local dir="${BOOTSTRAP_DIR}/${chart_name}"
    if [ ! -d "${dir}" ]; then
        echo_fail "${dir} not exists"
        exit 1
    fi
    pushd "${dir}" > /dev/null || exit 1
    helm repo add argo https://argoproj.github.io/argo-helm
    rm -fr Chart.lock charts
    helm dependency build
    helm upgrade --install "${chart_name}" . \
        --namespace "${ARGOCD_NAMESPACE}" \
        --values "values.yaml" \
        --values "values-${CLOUD}-${ENV}.yaml"
    sleep 10
    popd > /dev/null || exit 1
    echo_success "${chart_name} installed"
}

function crds_install() {
    pushd ${BOOTSTRAP_DIR} > /dev/null || exit 1
    kustomize build crds | kubectl apply --server-side -f -
    popd > /dev/null || exit 1
    echo_success "CRDs created"
}

function argocd_helm() {
    kubectl create namespace "${ARGOCD_NAMESPACE}"
    echo_success "Namespace ${ARGOCD_NAMESPACE} created"
    kubectl apply -f "${SECRETS_HOME}/${CLOUD}/${ENV}/argo-cd/argo-cd-notifications.yaml"
    echo_success "Argo-CD Notifications secret created"
    helm_install "argo-cd"
    echo_success "Argo-CD projects and applications created"
}

case ${choice} in
    # manifests)
    #     argocd_manifests "${ARGOCD_VERSION}"
    #     crds_install
    #     ;;
    helm)
        argocd_helm
        crds_install
        ;;
    *)
        echo_fail "Invalid choice. Must be manifests or helm."
        exit 1
        ;;
esac
