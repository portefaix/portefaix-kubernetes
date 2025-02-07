# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/scw.*.mk

SCW_PROJECT = $(SCW_PROJECT_$(ENV))
SCW_REGION  = $(SCW_REGION_$(ENV))
CLUSTER     = $(SCW_CLUSTER_$(ENV))


# ====================================
# S C A L E W A Y
# ====================================

##@ Scaleway

.PHONY: scw-init
scw-init: guard-ENV ## Initialize the Scaleway CLI
	@echo -e "$(INFO_COLOR)Configure the Scaleway CLI with S3 tools$(NO_COLOR)"
	@scw object config install type=s3cmd

.PHONY: scw-bucket
scw-bucket: guard-ENV ## Setup the bucket for Terraform states
	@echo -e "$(INFO_COLOR)Create the bucket for Terraform tfstates$(NO_COLOR)"
	@s3cmd mb s3://$(SCW_PROJECT)-tfstates

.PHONY: scw-kube-kapsule
scw-kube-kapsule: guard-ENV ## Scaleway Kapsule
	$(eval ID=$(shell scw k8s cluster list -o json | jq -r '.[] | select(.name="$(CLUSTER)") | .id'))
	@scw k8s cluster get $(ID)

.PHONY: scw-kube-credentials
scw-kube-credentials: guard-ENV ## Generate credentials
	$(eval ID=$(shell scw k8s cluster list -o json | jq -r '.[] | select(.name="$(CLUSTER)") | .id'))
	@scw k8s kubeconfig install $(ID)
