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

dir=$1

[ -z "${dir}" ] && echo "Chart directory not satisfied" && exit 1

manifest="${dir}/Chart.yaml"
[ ! -f "${manifest}" ] && echo "Chart file not exists" && exit 1

CHART_REPO_URL=$(yq e '.dependencies.0.repository' "${manifest}")
export CHART_REPO_URL
CHART_NAME=$(yq e '.dependencies.0.name' "${manifest}")
export CHART_NAME
CHART_VERSION=$(yq e '.dependencies.0.version' "${manifest}")
export CHART_VERSION
# CHART_NAMESPACE=$(yq e '.spec.targetNamespace' "${manifest}")
# export CHART_NAMESPACE

export CHART_REPO_NAME=${CHART_NAME}

# Debug:
if [ -n "${DEBUG}" ]; then
    echo "${CHART_REPO_URL}"
    echo "${CHART_REPO_NAME}"
    echo "${CHART_NAME}"
    echo "${CHART_VERSION}"
    # echo "${CHART_NAMESPACE}"
fi
