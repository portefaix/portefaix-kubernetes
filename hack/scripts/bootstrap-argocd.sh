#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

reset_color="\\e[0m"
color_red="\\e[31m"
color_green="\\e[32m"
color_blue="\\e[36m"

# SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function echo_fail { echo -e "${color_red}\U2716 $*${reset_color}"; }
function echo_success { echo -e "${color_green}\U2714 $*${reset_color}"; }
function echo_info { echo -e "${color_blue}\uf120 $*${reset_color}"; }
function echo_debug { echo -e "${color_blue}\U2712 $*${reset_color}"; }

GITOPS_ARGOCD="./gitops/argocd"
BOOTSTRAP_DIR="${GITOPS_ARGOCD}/charts"
SECRETS_HOME=".secrets"

ARGOCD_NAMESPACE="gitops"
# ARGOCD_VERSION="v4.2.1"

CLOUD=$1
[ -z "${CLOUD}" ] && echo_fail "Cloud provider not satisfied" && exit 1
echo_info "[Check] Cloud provider : ${CLOUD}"

ENV=$2
[ -z "${ENV}" ] && echo_fail "Environment not satisfied" && exit 1
ENV="${ENV//-tailscale/}"
echo_info "[Check] Environment    : ${ENV}"

choice=$3
[ -z "${choice}" ] && echo_fail "Setup choice not satisfied" && exit 1
echo_info "[Check] Choice         : ${choice}"

function helm_install() {
    local chart_name=$1
    local namespace=$2

    local dir="${BOOTSTRAP_DIR}/${namespace}/${chart_name}"
    if [ ! -d "${dir}" ]; then
        echo_fail "${dir} not exists"
        exit 1
    fi

    pushd "${dir}" >/dev/null || exit 1
    rm -fr Chart.lock charts
    helm dependency build
    if [ "${chart_name}" == "crds" ]; then
        helm upgrade --install "${chart_name}" .
    else
        helm upgrade --install "${chart_name}" . \
            --namespace "${namespace}" --create-namespace \
            --values "values.yaml" \
            --values "values-${CLOUD}-${ENV}.yaml"
    fi
    # shellcheck disable=SC2181
    if [ $? -eq 0 ]; then
        popd >/dev/null || exit 1
        echo_success "${chart_name} installed"
    else
        echo_fail "${chart_name} not installed"
        exit 1
    fi
    sleep 10
}

function crds_install() {
    # pushd ${BOOTSTRAP_DIR} >/dev/null || exit 1
    echo_info "[Kustomize] CRDs setup"
    # kustomize build crds --enable-helm | kubectl apply --server-side -f -
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo add wiremind https://wiremind.github.io/wiremind-helm-charts
    helm repo add portefaix-hub https://charts.portefaix.xyz/
    helm_install "crds" "crds"
    # popd >/dev/null || exit 1
    echo_success "[Kubernetes] CRDs created"
}

function argocd_helm() {
    NS=$(kubectl get namespace ${ARGOCD_NAMESPACE} --ignore-not-found)
    if [[ ! "${NS}" ]]; then
        kubectl create namespace "${ARGOCD_NAMESPACE}"
        echo_success "[Kubernetes] Namespace ${ARGOCD_NAMESPACE} created"
    fi
    kustomize build "${SECRETS_HOME}/${CLOUD}/${ENV}/gitops" | kubectl apply -f -
    kustomize build "${SECRETS_HOME}/${CLOUD}/${ENV}/external-secrets" | kubectl apply -f -
    echo_success "[Kubernetes] Secrets created"
    helm repo add argo https://argoproj.github.io/argo-helm
    helm_install "argo-cd" "${ARGOCD_NAMESPACE}"
    echo_success "[Helm] Argo-CD projects and applications created"
}

function cilium_helm() {
    helm repo add cilium https://helm.cilium.io
    helm_install "cilium" "kube-system"
}

case "${choice}" in
crds)
    crds_install
    ;;
cilium)
    # crds_install
    # sleep 10
    cilium_helm
    ;;
argocd)
    # crds_install
    # sleep 10
    argocd_helm
    ;;
*)
    echo_fail "Invalid choice: ${choice}. Must be manifests or crds."
    exit 1
    ;;
esac
