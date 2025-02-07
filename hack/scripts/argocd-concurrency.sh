#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

reset_color="\\e[0m"
color_red="\\e[31m"
color_green="\\e[32m"
color_blue="\\e[36m"

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}\uf120 $*${reset_color}"; }

DIR=$1
[ -z "${DIR}" ] && echo_fail "Argo-CD charts directory not satisfied" && exit 1
echo_info "Argo-CD charts directory : ${DIR}" >&2

# shellcheck disable=SC2044
for file in $(find "${DIR}" -name "Chart.yaml"); do
    chart_dir=$(dirname "${file}")
    if [ -d "${chart_dir}" ]; then
        pushd "${chart_dir}" >/dev/null || exit 1
        touch .argocd-allow-concurrency
        popd >/dev/null || exit 1
    fi
done
echo_info "Done"
