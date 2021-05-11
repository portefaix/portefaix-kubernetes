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
DEBUG_COLOR="\e[34m"
INFO_COLOR="\e[32m"
ERROR_COLOR="\e[31m"
WARN_COLOR="\e[35m"

function usage() {
    echo "Usage: $0 <manifests>"
}

function validate_helm_values() {
    dir=$1
    overlay=$2
    policy=$3

    for k_file in $(find ${dir}/base -type f -name "kustomization.yaml" | grep -v namespace)
    do
        manifests_dir=$(dirname $k_file)
        for file in $(find ${manifests_dir} -name *.yaml -type f); do
            if grep -q "HelmRelease" ${file}
            then
                make opa-policy-base CHART=${file} ENV=${overlay} POLICY=${policy}
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
validate_helm_values ${manifests} ${overlay} ${policy}
