#!/usr/bin/env bash

# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
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
#
# SPDX-License-Identifier: Apache-2.0

reset_color="\\e[0m"
color_red="\\e[31m"
color_green="\\e[32m"
color_blue="\\e[36m";

# SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}\uf120 $*${reset_color}"; }

AWS_ACCOUNT_ID=$1
[ -z "${AWS_ACCOUNT_ID}" ] && echo_fail "AWS_ACCOUNT_ID not satisfied" && exit 1
AWS_ROLE=$2
[ -z "${AWS_ROLE}" ] && echo_fail "AWS_ROLE not satisfied" && exit 1
AWS_CLUSTER=$3
[ -z "${AWS_CLUSTER}" ] && echo_fail "AWS_CLUSTER not satisfied" && exit 1
AWS_REGION=$4
[ -z "${AWS_REGION}" ] && echo_fail "AWS_REGION not satisfied" && exit 1

AWS_SESSION="portefaix-aws-cli"

echo_info "[AWS] Assume role ${AWS_ROLE} on account ${AWS_ACCOUNT_ID}"
CREDENTIALS=$(aws sts assume-role --role-arn "arn:aws:iam::${AWS_ACCOUNT_ID}:role/${AWS_ROLE}" --role-session-name "${AWS_SESSION}")
if [ $? -eq 0 ]; then
    AWS_ACCESS_KEY_ID=$(echo "${CREDENTIALS}" | jq -r .Credentials.AccessKeyId)
    export AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY=$(echo "${CREDENTIALS}" | jq -r .Credentials.SecretAccessKey)
    export AWS_SECRET_ACCESS_KEY
    AWS_SESSION_TOKEN=$(echo "${CREDENTIALS}" | jq -r .Credentials.SessionToken)
    export AWS_SESSION_TOKEN
    echo_success "[AWS] You are now on account ${AWS_ACCOUNT_ID} 🔥"
else
    echo_fail "[AWS] Can't assume role for ${AWS_ACCOUNT_ID}/${AWS_ROLE}"
fi
