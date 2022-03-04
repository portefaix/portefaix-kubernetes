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

# set -o errexit
set -euo pipefail

NO_COLOR="\033[0m"
# DEBUG_COLOR="\e[34m"
OK_COLOR="\e[32m"
ERROR_COLOR="\e[31m"
# WARN_COLOR="\e[35m"
# INFO_COLOR="\e[36m"

function usage() {
    echo -e "${ERROR_COLOR}Usage: $0 <manifests> <overlay> <policy>${NO_COLOR}"
}

function tf_validate() {
    local infra=$1

    echo -e "${OK_COLOR}Infra component: ${NO_COLOR}${infra}"
    pushd "${infra}" > /dev/null
    terraform init -upgrade
    terraform validate
    popd > /dev/null
}

function check_infra() {
    local dir=$1

    if [ ! -d "${dir}" ]; then
        echo -e "${ERROR_COLOR}Invalid directory: ${dir}${NO_COLOR}"
        exit 1
    fi
    for tf_file in $(find "${dir}" -name "main.tf" | grep -v ".terraform"); do
        tf_dir=${tf_file%/*}
        tf_validate "${tf_dir}"
    done
}

if [ $# -ne 1 ];
then
    usage
    exit 1
fi

cloud_provider=$1
[ -z "${cloud_provider}" ] && echo -e "${ERROR_COLOR}Cloud Provider not satisfied${NO_COLOR}" && exit 1

check_infra "terraform/${cloud_provider}"
