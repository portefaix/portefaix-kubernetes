#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

manifest=$1

[ -z "${manifest}" ] && echo "HelmRelease file not satisfied" && exit 1

CHART_REPO_URL=$(grep registryUrl "${manifest}" | awk -F"=" '{ print $2 }')
export CHART_REPO_URL
CHART_REPO_NAME=$(yq e '.spec.chart.spec.sourceRef.name' "${manifest}")
export CHART_REPO_NAME
CHART_NAME=$(yq e '.spec.chart.spec.chart' "${manifest}")
export CHART_NAME
CHART_VERSION=$(yq e '.spec.chart.spec.version' "${manifest}")
export CHART_VERSION
CHART_NAMESPACE=$(yq e '.spec.targetNamespace' "${manifest}")
export CHART_NAMESPACE

# Debug:
if [ -n "${DEBUG}" ]; then
    echo "${CHART_REPO_URL}"
    echo "${CHART_REPO_NAME}"
    echo "${CHART_NAME}"
    echo "${CHART_VERSION}"
    echo "${CHART_NAMESPACE}"
fi
