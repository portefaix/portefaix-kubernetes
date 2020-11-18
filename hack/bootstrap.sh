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

NO_COLOR="\033[0m"
DEBUG_COLOR="\e[34m"
INFO_COLOR="\e[32m"
ERROR_COLOR="\e[31m"
WARN_COLOR="\e[35m"

# GOTK_VERSION=latest
GOTK_VERSION=v0.2.1
REPOSITORY=portefaix

ENV=$1
[ -z "${ENV}" ] && echo "Environment not satisfied" && exit 1

[ ! -d "${ENV}" ] && echo "Invalid cluster environment: ${ENV}" && exit 1

# Check Flux v2 prerequisites
flux check --pre
[[ $? -ne 0 ]] && echo "Prerequisites were not satisfied" && exit 1

if [[ -f .secrets/k8s-secret-sealed-secret-private-key.yaml ]]; then
	echo "Deleting existing sealed-secret key"
	# kubectl delete secrets sealed-secrets-keyps54x -n kube-system
	echo "Applying existing sealed-secret key"
	kubectl apply -f .secrets/k8s-secret-sealed-secret-private-key.yaml
fi

flux bootstrap github \
		--components=source-controller,kustomize-controller,helm-controller,notification-controller \
		--path=${ENV}/ \
		--version=${GOTK_VERSION} \
		--owner=${GITHUB_USERNAME} \
		--repository=${REPOSITORY} \
		--branch=master \
		--personal
