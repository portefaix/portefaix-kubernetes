# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))
DIR = $(shell pwd)

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/vultr.*.mk

VULTR_REGION = $(VULTR_REGION_$(ENV))

VULTR_CLUSTER = $(VULTR_CLUSTER_$(ENV))

# ====================================
# V U L T R
# ====================================

##@ Vultr

.PHONY: vultr-kube-credentials
vultr-kube-credentials: guard-ENV ## Generate credentials
	@export K8S_ID=$$(vultr-cli kubernetes list | grep -B 1 $(VULTR_CLUSTER) | head -n 1 | awk -F" " '{ print $$2 }') \
		&& vultr-cli kubernetes config $${K8S_ID} | base64 -d
