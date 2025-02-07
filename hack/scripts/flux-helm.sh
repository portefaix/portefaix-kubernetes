#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

# NO_COLOR="\033[0m"
# DEBUG_COLOR="\e[34m"
# INFO_COLOR="\e[32m"
# ERROR_COLOR="\e[31m"
# WARN_COLOR="\e[35m"

function usage() {
    echo "Usage: $0 <service> <overlay>"
}

function helm_values() {
    chart=$1
    overlay=$2
    # shellcheck disable=SC2001
    overlay_values=$(echo "${chart}" | sed -e "s#base#overlays/${overlay}#g")
    # echo "${overlay_values}"

    tmpfile=$(mktemp)
    if [ ! -f "${overlay_values}" ]; then
        # shellcheck disable=SC2016
        yq ea '. as $item ireduce ({}; . * $item )' "${chart}" | yq e '.spec.values' - >"${tmpfile}"
    else
        # shellcheck disable=SC2016
        yq ea '. as $item ireduce ({}; . * $item )' "${chart}" "${overlay_values}" | yq e '.spec.values' - >"${tmpfile}"
    fi
    echo "${tmpfile}"
}

if [ $# -ne 2 ]; then
    usage
else
    helm_values "$1" "$2"
fi
