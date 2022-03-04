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

NO_COLOR="\033[0m"
OK_COLOR="\033[32;01m"
# ERROR_COLOR="\033[31;01m"
# WARN_COLOR="\033[33;01m"
INFO_COLOR="\033[36m"
# WHITE_COLOR="\033[1m"

function usage() {
    echo "Usage: $0 <manifests> <overlay> <policy>"
}

function validate_helm_values() {
    dir=$1
    overlay=$2
    policy=$3

    for k_file in $(find "${dir}/base" -type f -name "kustomization.yaml" | grep -v namespace | sort -u)
    do
        manifests_dir=$(dirname "${k_file}")
        echo -e "${OK_COLOR}Component: ${NO_COLOR}${manifests_dir}"

        # shellcheck disable=SC2044
        for file in $(find "${manifests_dir}" -name '*.yaml' -type f | sort -u); do
            if grep -q "HelmRelease" "${file}"
            then
                echo -e "${INFO_COLOR}- HelmRelease:${NO_COLOR} ${file}"
                if [[ "${file}" =~ .*"base/crds".* ]]; then
                    echo -e "${INFO_COLOR}Do not check CRD${NO_COLOR}"
                else
                    # shellcheck disable=SC1091
                    DEBUG="${DEBUG}" . hack/scripts/chart-fluxcd.sh "${file}"
                    helm repo add "${CHART_REPO_NAME}" "${CHART_REPO_URL}"
                    helm repo update
                    make opa-policy-base CHART="${file}" ENV="${overlay}" POLICY="${policy}"
                fi
            fi
        done
    done
}

manifests=$1
[ -z "${manifests}" ] && echo "Manifests not satisfied" && exit 1
overlay=$2
[ -z "${overlay}" ] && echo "Overlay not satisfied" && exit 1
policy=$3
[ -z "${policy}" ] && echo "Policy not satisfied" && exit 1

chart=$4
if [ -n "${chart}" ]; then
    make opa-policy-base CHART="${chart}" ENV="${overlay}" POLICY="${policy}"
else
    validate_helm_values "${manifests}" "${overlay}" "${policy}"
fi
