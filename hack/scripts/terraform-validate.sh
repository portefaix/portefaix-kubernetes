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

# set -euo pipefail
set -o pipefail

# NO_COLOR="\033[0m"
# DEBUG_COLOR="\e[34m"
# OK_COLOR="\e[32m"
# ERROR_COLOR="\e[31m"
# WARN_COLOR="\e[35m"
# INFO_COLOR="\e[36m"

return_code=0

reset_color="\\e[0m"
color_red="\\e[31m"
color_green="\\e[32m"
color_blue="\\e[36m";

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}$*${reset_color}"; }

function usage() {
    echo_fail "Usage: $0 <cloud provider> [ <debug> ]"
}

function check_result() {
    local action=$1
    local code=$2
    local data=$3

    if [ "${code}" -eq 0 ]; then
        echo_success "OK: ${action}"
        if [ -n "${DEBUG}" ]; then
            cat "${data}"
        fi
    else
        echo_fail "KO: ${action}"
        cat "${data}"
        return_code=1
    fi
}

function tf_validate() {
    local infra=$1

    echo_info "Infra component: ${infra}"
    pushd "${infra}" > /dev/null || exit 1
    output=$(mktemp)
    terraform init -upgrade &> "${output}"
    check_result "init" $? "${output}"
    terraform validate &> "${output}"
    check_result "validate" $? "${output}"
    popd > /dev/null || exit 1
}

function check_infra() {
    local dir=$1

    if [ ! -d "${dir}" ]; then
        echo_fail "Invalid directory: ${dir}"
        exit 1
    fi
    for tf_file in $(find "${dir}" -name "main.tf" | grep -v ".terraform"); do
        tf_dir=${tf_file%/*}
        tf_validate "${tf_dir}"
    done
}

if [ $# -eq 0 ];
then
    usage
    exit 1
fi

cloud_provider=$1
[ -z "${cloud_provider}" ] && echo_fail "Cloud Provider not satisfied" && exit 1

DEBUG=${2:-""}

check_infra "terraform/${cloud_provider}"
echo_info "Terraform validation completed"
exit ${return_code}
