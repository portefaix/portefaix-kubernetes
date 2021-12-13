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

ARGOCD_NAMESPACE="argocd"
ARGOCD_VERSION="v2.1.7"
ARGOCD_HELM_VERSION="3.28.1"
# ARGOCD_APPSET_VERSION="1.7.0"
# ARGOCD_NOTIFS_VERSION="1.6.0"
# ARGO_ROLLOUTS="2.6.0"

function argocd_manifests() {
    local version=$1

    kubectl create namespace "${ARGOCD_NAMESPACE}"
    kubectl apply -n "${ARGOCD_NAMESPACE}" -f https://raw.githubusercontent.com/argoproj/argo-cd/${version}/manifests/install.yaml
}

function argocd_helm() {
    local cd_version=$1
    # local appset_version=$2
    # local notifs_version=$3

    helm repo add argo https://argoproj.github.io/argo-helm
    kubectl create namespace "${ARGOCD_NAMESPACE}"
    helm install argocd argo/argo-cd --namespace "${ARGOCD_NAMESPACE}" --version "${cd_version}" --values "${SCRIPT_DIR}/argocd-values.yaml"*
    echo_success "ArgoCD installed"
    sleep 10
    # helm install argocd-applicationset argo/argocd-applicationset --namespace "${ARGOCD_NAMESPACE}" --version "${appset_version}" --values "${SCRIPT_DIR}/argocd-appset-values.yaml"
    # echo_success "ArgoCD ApplicationSet installed"
    # sleep 10
    # helm install argo-rollouts argo/argo-rollouts --namespace "${ARGOCD_NAMESPACE}" --version "${rollouts_version}" --values "${SCRIPT_DIR}/argocd-rollouts-values.yaml"
    # echo_success "Argo Rollouts installed"
    # sleep 10
    # helm install argocd-notifications argo/argocd-notifications --namespace "${ARGOCD_NAMESPACE}" --version "${notifs_version}" --values "${SCRIPT_DIR}/argocd-notifs-values.yaml"
    # echo_success "ArgoCD Notifications installed"

    kustomize build gitops/argocd/core/${CLOUD}/${ENV}/argocd/projects | kubectl apply -f -
    echo_success "Argo project installed"
    sleep 10
    kustomize build gitops/argocd/core/${CLOUD}/${ENV}/argocd/apps | kubectl apply -f -
    echo_success "Argo core application installed"
    sleep 10
}

choice=$1
[ -z "${choice}" ] && echo_fail "Setup choice not satisfied" && exit 1

case ${choice} in
    manifests)
        argocd_manifests "${ARGOCD_VERSION}"
        ;;
    helm)
        argocd_helm "${ARGOCD_HELM_VERSION}" "${ARGOCD_APPSET_VERSION}" "${ARGOCD_NOTIFS_VERSION}"
        ;;
    *)
        echo_fail "Invalid choice. Must be manifests or helm."
        exit 1
        ;;
esac
