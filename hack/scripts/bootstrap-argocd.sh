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

# SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}$*${reset_color}"; }

CHARTS_DIR="./gitops/argocd/charts"

ARGOCD_NAMESPACE="argocd"

# ARGO_REPO_NAME="argo"
# ARGO_REPO_URL="https://argoproj.github.io/argo-helm"
ARGOCD_VERSION="v2.1.7"
# ARGOCD_HELM_VERSION="3.28.1"
# ARGOCD_APPSET_VERSION="1.7.0"
# ARGOCD_NOTIFS_VERSION="1.6.0"
# ARGO_ROLLOUTS="2.6.0"

# PROM_OPERATOR_VERSION="v0.52.1"

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

    pushd "${CHARTS_DIR}/core/${chart_name}" > /dev/null || exit 1
    helm dependency build
    helm upgrade --install "${chart_name}" . \
        --namespace "${ARGOCD_NAMESPACE}" \
        --values "values.yaml" \
        --values "values-${CLOUD}-${ENV}.yaml"
    sleep 10
    echo_success "${chart_name} installed"
    popd > /dev/null || exit 1
}

# function crds_install() {
#     kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagerconfigs.yaml
#     kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
#     kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
#     kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_probes.yaml
#     kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
#     kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
#     kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
#     kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml
#     echo_success "CRDs Prometheus Operator created"
# }

function argocd_helm() {
    # local cd_version=$1
    # local appset_version=$2
    # local notifs_version=$3

    kubectl create namespace "${ARGOCD_NAMESPACE}"
    echo_success "Namespace ${ARGOCD_NAMESPACE} created"

    # helm repo add "${ARGO_REPO_NAME}" "${ARGO_REPO_URL}"
    # helm upgrade --install argocd "${ARGO_REPO_NAME}/argo-cd" \
    #     --namespace "${ARGOCD_NAMESPACE}" \
    #     --version "${cd_version}" \
    #     --values "${CHARTS_DIR}/${CLOUD}/${ENV}/argocd-values.yaml"
    helm_install "argo-cd"

    # helm template argocd-applicationset "${ARGO_REPO_NAME}/argocd-applicationset" \
    #     --namespace "${ARGOCD_NAMESPACE}" \
    #     --version "${appset_version}" \
    #     --values "${CHARTS_DIR}/${CLOUD}/${ENV}/argocd-appset-values.yaml"
    # echo_success "ArgoCD ApplicationSet installed"
    # sleep 10
    echo helm_install "argocd-applicationset"

    # helm template argo-rollouts "${ARGO_REPO_NAME}/argo-rollouts" \
    #     --namespace "${ARGOCD_NAMESPACE}" \
    #     --version "${rollouts_version}" \
    #     --values "${CHARTS_DIR}/${CLOUD}/${ENV}/argocd-rollouts-values.yaml"
    # echo_success "Argo Rollouts installed"
    # sleep 10
    echo helm_install "argocd-rollouts"

    # helm template argocd-notifications "${ARGO_REPO_NAME}/argocd-notifications" \
    #     --namespace "${ARGOCD_NAMESPACE}" \
    #     --version "${notifs_version}" \
    #     --values "${CHARTS_DIR}/${CLOUD}/${ENV}/argocd-notifs-values.yaml"
    # echo_success "ArgoCD Notifications installed"
    # sleep 10
    echo helm_install "argocd-notifications"

    # kustomize build gitops/argocd/bootstrap/${CLOUD}/${ENV} | kubectl apply -f -
    helm_install "infra"

    echo_success "Argo projects and core applications created"
    sleep 10

    crds_install
}


case ${choice} in
    manifests)
        argocd_manifests "${ARGOCD_VERSION}"
        ;;
    helm)
        argocd_helm #"${ARGOCD_HELM_VERSION}" "${ARGOCD_APPSET_VERSION}" "${ARGOCD_NOTIFS_VERSION}"
        ;;
    *)
        echo_fail "Invalid choice. Must be manifests or helm."
        exit 1
        ;;
esac
