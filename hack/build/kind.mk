# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/kind.*.mk

CLUSTER = $(CLUSTER_$(ENV))

KUBE_CONTEXT = $(KUBE_CONTEXT_$(ENV))

# ====================================
# K I N D
# ====================================

##@ Kind

.PHONY: kind-create
kind-create: guard-ENV ## Creates a local Kubernetes cluster (ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Create Kubernetes cluster ${CLUSTER}$(NO_COLOR)"
	@kind create cluster --name=$(CLUSTER) --config=hack/kind/kind-config.yaml --wait 180s
	@echo "Please install the Nginx ingress controller:"
	@echo "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml"

.PHONY: kind-delete
kind-delete: guard-ENV ## Delete a local Kubernetes cluster (ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Delete Kubernetes cluster ${CLUSTER}$(NO_COLOR)"
	@kind delete cluster --name=$(CLUSTER)

.PHONY: kind-kube-credentials
kind-kube-credentials: guard-ENV ## Credentials for Kind (ENV=xxx)
	@kubectl config use-context $(KUBE_CONTEXT)
