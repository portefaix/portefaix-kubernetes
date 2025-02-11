#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
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
