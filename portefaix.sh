#!/usr/bin/env bash

# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

OK_COLOR="\e[32m"
# KO_COLOR="\e[31m"
NO_COLOR="\e[39m"

reset_color="\\e[0m"
color_red="\\e[31m"
color_green="\\e[32m"
color_blue="\\e[36m";

function echo_fail { echo -e "${color_red}✖ $*${reset_color}"; }
function echo_success { echo -e "${color_green}✔ $*${reset_color}"; }
function echo_info { echo -e "${color_blue}$*${reset_color}"; }

echo -e "${OK_COLOR}🏗  Configure Portefaix${NO_COLOR}"

if [ $# -ne 1 ]; then
    echo "Usage: $0 <cloud provider>"
else
    CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
    PORTEFAIX_CONFIG_HOME=${CONFIG_HOME}/portefaix
    CREDENTIALS=${PORTEFAIX_CONFIG_HOME}/portefaix.sh
    if [ ! -f "${CREDENTIALS}" ]; then
        echo_fail "File not found: ${CREDENTIALS}"
    else
        # shellcheck disable=SC1090
        echo -e "${OK_COLOR}📝 Load environement variables${NO_COLOR}"
        source "${CREDENTIALS}" "$1"

        echo_info "Terraform variables"
        export TF_VAR_portefaix_version="v0.43.0"

        # shellcheck disable=SC2181
        if [ $? -eq 0 ]; then
            echo -e "${OK_COLOR}🎉 Congratulations ! Portefaix is configured${NO_COLOR}"
        else
            echo_fail "Failed"
        fi
    fi
fi
