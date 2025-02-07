# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))
DIR = $(shell pwd)

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/civo.*.mk

CIVO_REGION = $(CIVO_REGION_$(ENV))

CIVO_CLUSTER = $(CIVO_CLUSTER_$(ENV))

# ====================================
# C I V O
# ====================================

##@ Civo

.PHONY: civo-kube-credentials
civo-kube-credentials: guard-ENV ## Generate credentials
	@civo kubernetes config $(CIVO_CLUSTER) --region $(CIVO_REGION) --save --merge
	@kubectl config use-context $(CIVO_CLUSTER)
