# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
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
