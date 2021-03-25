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
    echo "Usage: $0 <service> <overlay>"
}

function values() {
    service=$1
    overlay=$2
    tmpfile=$(mktemp)
    # echo ${service}
    base_values="${service}/$(basename ${service}.yaml)"
    # echo ${base_values}
    dir=$(echo ${service} | sed -e "s#base#overlays/${overlay}#g")
    overlay_values="${dir}/chart-values.yaml"
    # echo ${overlay_values}
    if [ -f ]; then
        yq ea '. as $item ireduce ({}; . * $item )' ${base_values} | yq e '.spec.values' - > ${tmpfile}
    else
        yq ea '. as $item ireduce ({}; . * $item )' ${base_values} ${overlay_values} | yq e '.spec.values' - > ${tmpfile}
    fi
    echo ${tmpfile}
}


if [ $# -ne 2 ]; then
    usage
else
    values $1 $2
fi
