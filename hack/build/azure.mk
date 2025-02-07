# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/azure.*.mk

ENVS = $(shell ls azure.*.mk | awk -F"." '{ print $$2 }')

AZ_RESOURCE_GROUP = $(AZ_RESOURCE_GROUP_$(ENV))
AZ_RESOURCE_GROUP_TAGS = $(AZ_RESOURCE_GROUP_TAGS_$(ENV))

AZ_CURRENT_RESOURCE_GROUP = $(shell az)

AZ_STORAGE_ACCOUNT= $(AZ_STORAGE_ACCOUNT_$(ENV))

AZ_LOCATION = $(AZ_LOCATION_$(ENV))

CLUSTER = $(CLUSTER_$(ENV))

AZ_SECRET_RESOURCE_GROUP = $(AZ_SECRET_RESOURCE_GROUP_$(ENV))

# Windows Azure Active Directory
AZURE_AD_ID = 00000002-0000-0000-c000-000000000000
# Directory.ReadWrite.All
AZURE_AD_PERMISSIONS_ID= 78c8a3c8-a07e-4b9e-af1b-b5ccab50a175

# Tags: tags/x.x.x.x
# Branch: heads/x.x.x.x
INSPEC_PORTEFAIX_AZURE_VERSION = tags/v0.1.0
INSPEC_PORTEFAIX_AZURE = https://github.com/portefaix/portefaix-inspec-azure/archive/refs/$(INSPEC_PORTEFAIX_AZURE_VERSION).zip


# ====================================
# A Z U R E
# ====================================

##@ Azure

.PHONY: azure-kube-credentials
azure-kube-credentials: guard-ENV ## Generate credentials
	@az aks get-credentials \
		--resource-group $(AZ_RESOURCE_GROUP) \
		--name $(CLUSTER) \
		--admin --overwrite-existing

.PHONY: azure-keyvault-create
azure-keyvault-create: guard-ENV ## Create a vault
	@echo -e "$(OK_COLOR)[$(APP)] Create a KeyVault$(NO_COLOR)"
	@az keyvault create --name portefaix-commons \
		--resource-group $(AZ_SECRET_RESOURCE_GROUP) --location $(AZ_LOCATION)

.PHONY: azure-secret-version-create
azure-secret-version-create: guard-ENV guard-VERSION ## Create a secret
	@echo -e "$(OK_COLOR)[$(APP)] Create a secret$(NO_COLOR)"
	@az keyvault secret set --vault-name portefaix-commons \
		--name portefaix-version --value $(VERSION)
