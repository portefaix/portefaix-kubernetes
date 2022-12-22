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

# NO_COLOR="\033[0m"
# DEBUG_COLOR="\e[34m"
# INFO_COLOR="\e[32m"
# ERROR_COLOR="\e[31m"
# WARN_COLOR="\e[35m"

ORGANIZATION=portefaix
REPOSITORY=portefaix
DEFAULT_BRANCH=master

GITOPS_FLUXCD="gitops/fluxcd"

reset_color="\\e[0m"
color_red="\\e[31m"
color_green="\\e[32m"
color_blue="\\e[36m";

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}$*${reset_color}"; }

FLUX_VERSION=v0.33.0

CLOUD=$1
[ -z "${CLOUD}" ] && echo_fail "Cloud provider not satisfied" && exit 1
echo_info "Cloud provider : ${CLOUD}"

ENV=$2
[ -z "${ENV}" ] && echo_fail "Environment not satisfied" && exit 1
ENV="${ENV//-tailscale/}"
echo_info "Environment    : ${ENV}"

FLUX_PATH="${GITOPS_FLUXCD}/clusters/${CLOUD}/${ENV}"
[ ! -d "${FLUX_PATH}" ] && echo_fail "Invalid cluster environment: ${FLUX_PATH}" && exit 1
echo_info "Flux           : ${FLUX_PATH}"

BRANCH=${3:-${DEFAULT_BRANCH}}
echo_info "Branch used    : ${BRANCH}"

# FLUX_ARGS=""
# if [ "homelab" == "${ENV}" ] ; then
# 	FLUX_ARGS="--toleration-keys=node.kubernetes.io/fluxcd"
# fi

# Check Flux v2 prerequisites
if ! flux check --pre; then
	echo "Prerequisites were not satisfied"
	exit 1
fi

flux bootstrap github \
	--path="${FLUX_PATH}" \
	--version="${FLUX_VERSION}" \
	--owner="${ORGANIZATION}" \
	--repository="${REPOSITORY}" \
	--branch="${BRANCH}" \
	--personal \
	--verbose \
	"${FLUX_ARGS}"

# sleep 10
# kustomize build "gitops/fluxcd/clusters/${CLOUD}/${ENV}/flux/weave-gitops" | kubectl apply -f -
