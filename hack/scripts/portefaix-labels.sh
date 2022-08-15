#!/usr/bin/env bash
# Copyright 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

reset_color="\\e[0m"
color_red="\\e[31m"
color_yellow="\\e[33m"
color_green="\\e[32m"
color_blue="\\e[36m"

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_warn { echo -e "${color_yellow}🚨 $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}$*${reset_color}"; }

k8s_label="portefaix.xyz/version"
hcl_aws_label="Portefaix-Version"
hcl_azure_label="portefaix-version"
hcl_gcp_label="portefaix-version"
ansible_label="portefaix_version"
terraform_variable="TF_VAR_portefaix_version"

function usage() {
    echo "Usage: $0 <directory> <file extension> <version>"
}

function update_shell_variables() {
    local file=$1
    grep  "${terraform_variable}" "${file}"
    if grep -q "${terraform_variable}" "${file}"; then
        sed -i "s#${terraform_variable}=.*#${terraform_variable}=\"${version}\"#g" "${file}"
    fi
}

function update_ansible_label() {
    local file=$1

    if grep -q "${ansible_label}" "${file}"; then
        sed -i "s#${ansible_label}:.*#${ansible_label}: ${version}#g" "${file}"
        echo_success "Ansible file updated: ${file}"
    fi
}

function update_k8s_label() {
    local file=$1

    if grep -q "${k8s_label}" "${file}"; then
        sed -i "s#${k8s_label}:.*#${k8s_label}: ${version}#g" "${file}"
        echo_success "Kubernetes file updated: ${file}"
    fi
}

function update_hcl_label() {
    local file=$1
    local cloud=$2

    case "${cloud}" in
        aws)
            if grep -q "${hcl_aws_label}" "${file}"; then
                sed -i "s#\"${hcl_aws_label}\" = .*#\"${hcl_aws_label}\" = \"${version}\"#g" "${file}"
            fi
            ;;
        azure)
            if grep -q "${hcl_azure_label}" "${file}"; then
                sed -i "s#\"${hcl_azure_label}\" = .*#\"${hcl_azure_label}\" = \"${version}\"#g" "${file}"
            fi
            ;;
        gcp)
            if grep -q "${hcl_gcp_label}" "${file}"; then
                gcp_version="${version//\./-}"
                sed -i "s#${hcl_gcp_label} = .*#${hcl_gcp_label} = \"${gcp_version}\"#g" "${file}"
            fi
            ;;
        *)
            echo_fail "Invalid cloud provider: ${cloud}"
            exit 1
            ;;
    esac
    echo_success "Terraform file updated: ${file}"
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
        find "${dir}" -name "*.${ext}" -print0 | while IFS= read -r -d $'\0' k8s_file;
        do
            update_k8s_label "${k8s_file}"
        done
        ;;
    tfvars)
        [ -z "${cloud_provider}" ] && echo_fail "Cloud provider not satisfied" && exit 1
        find "${dir}/${cloud_provider}" -name "*.${ext}" -print0 | while IFS= read -r -d $'\0' hcl_file;
        do
            update_hcl_label "${hcl_file}" "${cloud_provider}"
        done
        ;;
    yml)
        find "${dir}" -name "*.${ext}" -print0 | while IFS= read -r -d $'\0' ansible_file;
        do
            update_ansible_label "${ansible_file}"
        done
        ;;
    sh)
        update_shell_variables "portefaix.sh"
        ;;

    *)
        echo_fail "Invalid extension: ${ext}"
        ;;
    esac
