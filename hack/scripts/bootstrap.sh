#!/usr/bin/env bash

# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

# NO_COLOR="\033[0m"
# DEBUG_COLOR="\e[34m"
# INFO_COLOR="\e[32m"
# ERROR_COLOR="\e[31m"
# WARN_COLOR="\e[35m"

ORGANIZATION=portefaix
REPOSITORY=portefaix
DEFAULT_BRANCH=master

# FLUX_VERSION=latest
FLUX_VERSION=v0.15.1

ENV=$1
[ -z "${ENV}" ] && echo "Environment not satisfied" && exit 1
[ ! -d "${ENV}" ] && echo "Invalid cluster environment: ${ENV}" && exit 1

BRANCH=${2:-${DEFAULT_BRANCH}}

echo "Branch used: ${BRANCH}"

# Check Flux v2 prerequisites
if ! flux check --pre; then
	echo "Prerequisites were not satisfied"
	exit 1
fi

flux bootstrap github \
		--components=source-controller,kustomize-controller,helm-controller,notification-controller \
		--path="${ENV}" \
		--version="${FLUX_VERSION}" \
		--owner="${ORGANIZATION}" \
		--repository="${REPOSITORY}" \
		--branch="${BRANCH}" \
		--personal \
		--verbose
