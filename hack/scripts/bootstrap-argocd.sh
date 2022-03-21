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

GITOPS_ARGOCD="./gitops/argocd"
CLUSTERS_DIR="${GITOPS_ARGOCD}/clusters"

ARGOCD_NAMESPACE="argocd"
ARGOCD_VERSION="v4.2.1"
PROM_OPERATOR_VERSION="v0.55.0"

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

    local dir="${CLUSTERS_DIR}/${chart_name}"
    if [ ! -d "${dir}" ]; then
        echo_fail "${dir} not exists"
        exit 1
    fi
    pushd "${dir}" > /dev/null || exit 1
    helm dependency build
    helm upgrade --install "${chart_name}" . \
        --namespace "${ARGOCD_NAMESPACE}" \
        --values "values.yaml" \
        --values "values-${CLOUD}-${ENV}.yaml"
    sleep 10
    echo_success "${chart_name} installed"
    popd > /dev/null || exit 1
}

function crds_install() {
    kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagerconfigs.yaml
    kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
    kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
    kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_probes.yaml
    kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
    kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
    kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
    kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${PROM_OPERATOR_VERSION}/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml
    echo_success "CRDs Prometheus Operator created"
}

function argocd_helm() {
    kubectl create namespace "${ARGOCD_NAMESPACE}"
    echo_success "Namespace ${ARGOCD_NAMESPACE} created"
    helm_install "argo-cd"
    # echo helm_install "argo-rollouts"
    # echo helm_install "argo-events"
    echo_success "Argo projects and applications created"
    # crds_install
}


case ${choice} in
    manifests)
        argocd_manifests "${ARGOCD_VERSION}"
        crds_install
        ;;
    helm)
        argocd_helm
        crds_install
        ;;
    *)
        echo_fail "Invalid choice. Must be manifests or helm."
        exit 1
        ;;
esac
