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

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/minikube.*.mk

CLUSTER = $(CLUSTER_$(ENV))

KUBE_CONTEXT = $(KUBE_CONTEXT_$(ENV))

# ====================================
# M I N I K U B E
# ====================================

##@ Minikube

.PHONY: minikube-create
minikube-create: guard-ENV ## Creates a local Kubernetes cluster (ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Create Kubernetes cluster ${CLUSTER}$(NO_COLOR)"
	@minikube start --container-runtime=containerd --cpus=2 --memory=2g --profile=$(CLUSTER)

.PHONY: minikube-delete
minikube-delete: guard-ENV ## Delete a local Kubernetes cluster (ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Delete Kubernetes cluster ${CLUSTER}$(NO_COLOR)"
	@minikube delete --profile=$(CLUSTER)

.PHONY: minikube-kube-credentials
minikube-kube-credentials: guard-ENV ## Credentials for Kind (ENV=xxx)
	@kubectl config use-context $(KUBE_CONTEXT)
