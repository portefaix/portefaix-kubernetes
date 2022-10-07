# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/azure.*.mk

ENVS = $(shell ls azure.*.mk | awk -F"." '{ print $$2 }')

AZ_CURRENT_RESOURCE_GROUP = $(shell az)

AZ_ORG = portefaix
AZ_LOCATION = westeurope
AZ_TAGS = "project=portefaix made-by=azcli"

# AZ_RESOURCE_GROUP = $(AZ_RESOURCE_GROUP_$(ENV))
# AZ_RESOURCE_GROUP_TAGS = $(AZ_RESOURCE_GROUP_TAGS_$(ENV))
# AZ_STORAGE_ACCOUNT= $(AZ_STORAGE_ACCOUNT_$(ENV))
# AZ_LOCATION = $(AZ_LOCATION_$(ENV))
# AZ_SECRET_RESOURCE_GROUP = $(AZ_SECRET_RESOURCE_GROUP_$(ENV))

CLUSTER = $(CLUSTER_$(ENV))

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

.PHONY: azure-storage-account
azure-storage-account: ## Create storage account
	@az group create --name $(AZ_ORG) \
		--location $(AZ_LOCATION) \
		--tags '$(AZ_TAGS)'
	@az storage account create --name $(AZ_ORG) \
		--resource-group $(AZ_ORG) \
		--location $(AZ_LOCATION)
	@az storage account keys list \
		--resource-group $(AZ_ORG) \
		--account-name $(AZ_ORG) --query [0].value -o tsv

.PHONY: azure-storage-container
azure-storage-container: guard-KEY ## Create storage coutainer
	@az storage container create --name $(AZ_ORG)-tfstates \
		--account-name $(AZ_ORG) \
		--account-key $(KEY)

.PHONY: azure-sp
azure-sp: ## Create Azure Service Principal
	@az ad sp create-for-rbac \
		--name=$(AZ_ORG) \
		--role="Contributor" --scopes="/subscriptions/${AZURE_SUBSCRIPTION_ID}"

.PHONY: azure-permissions
azure-permissions: guard-ENV guard-ARM_CLIENT_ID
	@az ad app permission add --id $(ARM_CLIENT_ID) --api $(AZURE_AD_ID) --api-permissions $(AZURE_AD_PERMISSIONS_ID)=Role
	@az ad app permission grant --id $(ARM_CLIENT_ID) --api $(AZURE_AD_ID)
	@az ad app permission admin-consent --id $(ARM_CLIENT_ID)
# @az ad app permission add --id $(ARM_CLIENT_ID) --api $(AZURE_AD_ID) --api-permissions "("{0}=Scope" -f $(AZURE_AD_PERMISSIONS_ID))"

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

.PHONY: azure-kube-credentials
azure-kube-credentials: guard-ENV ## Generate credentials
	@az aks get-credentials \
		--resource-group $(AZ_RESOURCE_GROUP) \
		--name $(CLUSTER) \
		--admin --overwrite-existing


# ====================================
# I N S P E C
# ====================================

##@ Inspec

.PHONY: inspec-debug
inspec-azure-debug: ## Test inspec
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@bundle exec inspec detect -t azure://

.PHONY: inspec-test
inspec-azure-test: guard-SERVICE guard-ENV ## Test inspec
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@bundle exec inspec exec $(SERVICE)/inspec \
		-t azure:// --input-file=$(SERVICE)/inspec/attributes/$(ENV).yml \
		--reporter cli json:$(AZ_RESOURCE_GROUP)_$(SERVICE).json html:$(AZ_RESOURCE_GROUP)_$(SERVICE).html

.PHONY: inspec-azure-portefaix
inspec-azure-portefaix: guard-ENV ## Test inspec
	@echo -e "$(OK_COLOR)Test infrastructure with Portefaix Azure profile$(NO_COLOR)"
	@bundle exec inspec exec \
		$(INSPEC_PORTEFAIX_AZURE) \
		-t azure:// --input-file=inspec/azure/attributes/portefaix-$(ENV).yml  \
		--reporter cli json:$(AZ_RESOURCE_GROUP)_cis.json html:$(AZ_RESOURCE_GROUP)_cis.html

.PHONY: inspec-azure-cis
inspec-azure-cis: guard-ENV ## Test inspec
	@echo -e "$(OK_COLOR)CIS Microsoft Azure Foundations benchmark$(NO_COLOR)"
	@bundle exec inspec exec \
		https://github.com/mitre/microsoft-azure-cis-foundations-baseline.git \
		-t azure:// --input-file=inspec/azure/attributes/portefaix-$(ENV).yml  \
		--reporter cli json:$(AZ_RESOURCE_GROUP)_cis.json html:$(AZ_RESOURCE_GROUP)_cis.html

.PHONY: inspec-azure-kubernetes
inspec-azure-kubernetes: guard-ENV ## Kubernetes CIS
	@echo -e "$(OK_COLOR)CIS Kubernetes benchmark$(NO_COLOR)"
	@bundle exec inspec exec \
		https://github.com/dev-sec/cis-kubernetes-benchmark.git \
		--reporter cli json:$(AZ_RESOURCE_GROUP)_k8s.json html:$(AZ_RESOURCE_GROUP)_k8s.html
