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
CLUSTERS_DIR="${GITOPS_ARGOCD}/charts/clusters"
ARGOCD_NAMESPACE="argocd"

CLOUD=$1
[ -z "${CLOUD}" ] && echo_fail "Cloud provider not satisfied" && exit 1
echo_info "Cloud provider : ${CLOUD}"

ENV=$2
[ -z "${ENV}" ] && echo_fail "Environment not satisfied" && exit 1
ENV="${ENV//-tailscale/}"
echo_info "Environment    : ${ENV}"

APP=$3
[ -z "${APP}" ] && echo_fail "Application not satisfied" && exit 1
echo_info "Application    : ${APP}"

dir="${CLUSTERS_DIR}/${APP}"
if [ ! -d "${dir}" ]; then
    echo_fail "${APP} not exists. [${dir}]"
    exit 1
fi

pushd "${dir}" > /dev/null || exit 1
helm dependency build
helm upgrade --install "${APP}" . \
    --namespace "${ARGOCD_NAMESPACE}" \
    --values "values.yaml" \
    --values "values-${CLOUD}-${ENV}.yaml"
sleep 10
echo_success "${APP} installed"
popd > /dev/null || exit 1
