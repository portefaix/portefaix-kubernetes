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

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}\uf120 $*${reset_color}"; }

DIR=$1
[ -z "${DIR}" ] && echo_fail "Argo-CD charts directory not satisfied" && exit 1
echo_info "Argo-CD charts directory : ${DIR}" >&2

for file in $(find ${DIR} -name "Chart.yaml"); do
    chart_dir=$(dirname "${file}")
    if [ -d "${chart_dir}" ]; then
        pushd "${chart_dir}" > /dev/null || exit 1
        touch .argocd-allow-concurrency
        popd > /dev/null || exit 1
    fi
done
echo_info "Done"