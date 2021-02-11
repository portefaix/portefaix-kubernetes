# Copyright (C) 2018-2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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
    echo "Usage: $0 <cloud provider> <env> <action>"
}


function k8s_app() {
    local cloud_provider=$1 ; shift
    local env=$1 ; shift
    local action=$1 ; shift
    local namespace=$1 ; shift            
    local apps=("$@") 

    for app in ${apps[@]}; do
        echo -e "${INFO_COLOR}Terraform ${action} : ${app}${NO_COLOR}"
        echo no | make terraform-${action} SERVICE=iac/${cloud_provider}/kubernetes/${namespace}/${app} ENV=${env}
        sleep 1
    done
}

function k8s_monitoring() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    apps=(namespace kube-prometheus-stack thanos)
    k8s_app ${cloud_provider} ${env} ${action} "monitoring" "${apps[@]}"
}

function k8s_logging() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    apps=(namespace loki fluentbit)
    k8s_app ${cloud_provider} ${env} ${action} "logging" "${apps[@]}"
}

function k8s_identity() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    apps=(namespace pomerium)
    k8s_app ${cloud_provider} ${env} ${action} "identity" "${apps[@]}"
}

function k8s_dns() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    apps=(namespace external-dns)
    k8s_app ${cloud_provider} ${env} ${action} "dns" "${apps[@]}"
}

function k8s_cert_manager() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    apps=(namespace cert-manager letsencrypt)
    k8s_app ${cloud_provider} ${env} ${action} "cert-manager" "${apps[@]}"
}

function k8s_ingress_controllers() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    apps=(namespace ingress-nginx)
    k8s_app ${cloud_provider} ${env} ${action} "ingress-controllers" "${apps[@]}"
}

function k8s_storage() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    apps=(namespace velero)
    k8s_app ${cloud_provider} ${env} ${action} "storage" "${apps[@]}"
}


function main() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    k8s_monitoring ${cloud_provider} ${env} ${action}
    k8s_logging ${cloud_provider} ${env} ${action}
    k8s_cert_manager ${cloud_provider} ${env} ${action}
    k8s_dns ${cloud_provider} ${env} ${action}
    k8s_identity ${cloud_provider} ${env} ${action}
    k8s_ingress_controllers ${cloud_provider} ${env} ${action}
    k8s_storage ${cloud_provider} ${env} ${action}

}

if [ $# -ne 3 ]; then
    usage
else
    case $3 in
        apply|destroy)
            main $1 $2 $3
            ;;
        *)
            usage
            ;;
    esac    
fi
