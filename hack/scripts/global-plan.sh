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

# set -euo pipefail
shopt -s nullglob # enable

reset_color="\\e[0m"
color_red="\\e[31m"
color_yellow="\\e[33m"
color_green="\\e[32m"
color_blue="\\e[36m"

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_warn { echo -e "${color_yellow}🚨 $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}$*${reset_color}"; }

function tf_plan {
    tf_service=$1
    tf_env=$2

    pushd ${tf_service} > /dev/null
    tf_output=$(terraform init -reconfigure -backend-config=backend-vars/${tf_env}.tfvars 2>&1)
    if [ $? -ne 0 ]; then
        echo ${tf_output}
        exit 1
    fi
    tf_output=$(terraform plan -lock-timeout=60s -detailed-exitcode -var-file=tfvars/${tf_env}.tfvars 2>&1)
    exit_status=$?
    # echo ${exit_status}
    result="${exit_status}"
    case "${exit_status}" in
        0)
            echo_success "${tf_env}"
            ;;
        1)
            echo_fail "${tf_env}"
            # echo -e ${tf_output}
            ;;
        2)
            echo_warn "${tf_env}"
            # echo -e ${tf_output}
            ;;
        *)
            echo_fail "General error"
            # echo -e ${tf_output}
            ;;
    esac
    popd > /dev/null
}

function tf_service {
    tf_service=$1

    for tf_env in $(ls ${tf_service}/tfvars/*.tfvars); do
        tf_env=$(basename ${tf_env%.*})
        tf_plan ${tf_service} ${tf_env}
    done
}

infra=$1
[ -z "${infra}" ] && echo_fail "Infrastructure not satisfied" && exit 1

for dir in $(find ${infra} -name terraform -type d | grep -v "\.terraform");
do
    service_dir="${dir%/*}"
    echo_info "Service: ${service_dir}"
    tf_service ${dir}
done
