# Copyright (C) 2020-2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

    local components="${apps[@]}"
    if [ "${action}" == "destroy" ]; then
        components=$(echo "${apps[@]}" | tac -s ' ' | tr '\n' ' ')
    fi

    for app in ${components[@]}; do
        echo -e "${DEBUG_COLOR}Terraform ${action} : ${app}${NO_COLOR}"
        echo yes | make terraform-${action} SERVICE=iac/${cloud_provider}/kubernetes/${namespace}/${app} ENV=${env}
        sleep 1
    done
}

function k8s_monitoring() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    local namespace="monitoring"
    local apps=(namespace kube-prometheus-stack thanos)
    echo -e "${INFO_COLOR}${namespace} stack${NO_COLOR}"
    k8s_app ${cloud_provider} ${env} ${action} ${namespace} "${apps[@]}"    
}

function k8s_logging() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    local namespace="logging"
    local apps=(namespace loki fluentbit)
    echo -e "${INFO_COLOR}${namespace} stack${NO_COLOR}"
    k8s_app ${cloud_provider} ${env} ${action} ${namespace} "${apps[@]}"
}

function k8s_identity() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    local namespace="identity"
    local apps=(namespace pomerium)
    echo -e "${INFO_COLOR}${namespace} stack${NO_COLOR}"
    k8s_app ${cloud_provider} ${env} ${action} ${namespace} "${apps[@]}"
}

function k8s_dns() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    local namespace="dns"
    local apps=(namespace external-dns)
    echo -e "${INFO_COLOR}${namespace} stack${NO_COLOR}"
    k8s_app ${cloud_provider} ${env} ${action} ${namespace} "${apps[@]}"
}

function k8s_cert_manager() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    local namespace="cert-manager"
    local apps=(namespace cert-manager letsencrypt)
    echo -e "${INFO_COLOR}${namespace} stack${NO_COLOR}"
    k8s_app ${cloud_provider} ${env} ${action} ${namespace} "${apps[@]}"
}

function k8s_ingress_controllers() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    local namespace="ingress-controllers"
    local apps=(namespace ingress-nginx)
    echo -e "${INFO_COLOR}${namespace} stack${NO_COLOR}"
    k8s_app ${cloud_provider} ${env} ${action} ${namespace} "${apps[@]}"
}

function k8s_storage() {
    local cloud_provider=$1
    local env=$2
    local action=$3

    local namespace="storage"
    local apps=(namespace velero)
    echo -e "${INFO_COLOR}${namespace} stack${NO_COLOR}"
    k8s_app ${cloud_provider} ${env} ${action} ${namespace} "${apps[@]}"
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
