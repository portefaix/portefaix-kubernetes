# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/ibmcloud.*.mk

IBMCLOUD_RESOURCE_GROUP_NAME = $(IBMCLOUD_RESOURCE_GROUP_NAME_$(ENV))
IBMCLOUD_REGION = $(IBMCLOUD_REGION_$(ENV))

IBMCLOUD_COS_SERVICE_NAME = $(IBMCLOUD_COS_SERVICE_NAME_$(ENV))
IBMCLOUD_COS_SERVICE_PLAN = $(IBMCLOUD_COS_SERVICE_PLAN_$(ENV))
IBMCLOUD_COS_BUCKET_NAME = $(IBMCLOUD_COS_BUCKET_NAME_$(ENV))

# ====================================
# I B M C L O U D
# ====================================

##@ IBMCloud

.PHONY: ibmcloud-init
ibmcloud-init: guard-ENV ## Login to IBMCloud
	@echo -e "$(OK_COLOR)[$(APP)] Login$(NO_COLOR)"
	@ibmcloud plugin install cloud-object-storage
	@ibmcloud plugin install kubernetes-service
	@ibmcloud login -r $(IBMCLOUD_REGION) --apikey $${IC_API_KEY}
	@ibmcloud cos config list

.PHONY: ibmcloud-kube-credentials
ibmcloud-kube-credentials: guard-ENV ## Generate credentials
	@export IKS_ID=$$(ibmcloud ks cluster get --cluster portefaix-staging-iks --output json | jq -r '.id') \
		&& ibmcloud ks cluster config -c $${IKS_ID}
