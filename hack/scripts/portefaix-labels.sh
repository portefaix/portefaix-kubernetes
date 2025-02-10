#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

reset_color="\\e[0m"
color_red="\\e[31m"
color_yellow="\\e[33m"
color_green="\\e[32m"
color_blue="\\e[34m"

function echo_fail { echo -e "${color_red}❌ $*${reset_color}"; }
function echo_warn { echo -e "${color_yellow}🚨 $*${reset_color}"; }
function echo_success { echo -e "${color_green}✅ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}💡 $*${reset_color}"; }

function usage() {
    echo "Usage: $0 <directory> <file extension> <version>"
}

function update_k8s_label() {
    local label=$1
    local file=$2

    if grep -q "${label}" "${file}"; then
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sed -i "s#${label}:.*#${label}: ${version}#g" "${file}"
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            gsed -i "s#${label}:.*#${label}: ${version}#g" "${file}"
        fi
        echo_success "Kubernetes file updated: ${file}"
    fi
}

dir=$1
[ -z "${dir}" ] && echo_fail "Directory not satisfied" && exit 1
ext=$2
[ -z "${ext}" ] && echo_fail "Extension not satisfied" && exit 1
version=$3
[ -z "${version}" ] && echo_fail "Version not satisfied" && exit 1
cloud_provider=$4

IFS="
"

echo_info "Extension: ${ext} ${cloud_provider}"
case "${ext}" in
yaml)
    find "${dir}" -name "*.${ext}" -print0 | while IFS= read -r -d $'\0' k8s_file; do
        update_k8s_label "portefaix.xyz/version" "${k8s_file}"
        update_k8s_label "portefaixVersion" "${k8s_file}"
    done
    ;;
json)
    find "${dir}" -name "*.${ext}" -print0 | while IFS= read -r -d $'\0' k8s_file; do
        # update_json_version "" "${k8s_file}"
        echo_warn "Not supported ${k8s_file}"
    done
    ;;
*)
    echo_fail "Invalid extension: ${ext}"
    ;;
esac
