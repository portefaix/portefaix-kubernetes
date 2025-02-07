# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/exoscale.*.mk

EXO_PROJECT = $(EXO_PROJECT_$(ENV))
EXO_REGION  = $(EXO_REGION_$(ENV))

CLUSTER     = $(EXO_CLUSTER_$(ENV))

BUNDLE_PATH=$(DIR)/vendor/bundle/ruby/2.7.0/bin


# ====================================
# E X O S C A L E
# ====================================

##@ Exoscale

.PHONY: exo-kube-credentials
exo-kube-credentials: guard-ENV ## Generate credentials
	exo sks kubeconfig $(CLUSTER) admin -g system:masters > /tmp/exo-$(CLUSTER)
