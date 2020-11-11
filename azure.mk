# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

include commons.mk
include azure.*.mk

AZ_RESOURCE_GROUP = $(AZ_RESOURCE_GROUP_$(ENV))
AZ_CURRENT_RESOURCE_GROUP = $(shell az)

AZ_STORAGE_ACCOUNT= $(AZ_STORAGE_ACCOUNT_$(ENV))

AZ_LOCATION = $(AZ_LOCATION_$(ENV))

CLUSTER = $(CLUSTER_$(ENV))

RUBY_PATH=PATH=${HOME}/.gem/ruby/2.7.0/bin/:${PATH}


# ====================================
# A Z U R E
# ====================================

##@ Azure

.PHONY: azure-storage-account
azure-storage-account: guard-ENV ## Create storage account
	@az storage account create --name $(AZ_STORAGE_ACCOUNT) \
		--resource-group $(AZ_RESOURCE_GROUP) \
		--location $(AZ_LOCATION)
	@az storage account keys list \
		--resource-group $(AZ_RESOURCE_GROUP) \
		--account-name $(AZ_STORAGE_ACCOUNT) --query [0].value -o tsv

.PHONY: azure-storage-container
azure-storage-container: guard-ENV guard-KEY ## Create storage coutainer
	@az storage container create --name $(AZ_RESOURCE_GROUP)-tfstates \
		--account-name $(AZ_STORAGE_ACCOUNT) \
		--account-key $(KEY)

.PHONY: azure-keyvault-create
azure-keyvault-create: guard-ENV ## Create a secret
	@echo -e "$(OK_COLOR)[$(APP)] Create a KeyVault$(NO_COLOR)"
	@az keyvault create --name $(AZ_RESOURCE_GROUP) \
		--resource-group $(AZ_RESOURCE_GROUP) --location $(AZ_LOCATION)

.PHONY: azure-keyvault-create-secret
azure-keyvault-create-secret: guard-ENV guard-NAME guard-VALUE ## Create a secret
	@echo -e "$(OK_COLOR)[$(APP)] Create a secret for: $(NAME)$(NO_COLOR)"
	az keyvault secret set --vault-name $(AZ_RESOURCE_GROUP) \
		--name $(NAME) --value $(VALUE)

.PHONY: azure-kube-credentials
azure-kube-credentials: guard-ENV ## Generate credentials
	@az aks get-credentials --resource-group $(AZ_RESOURCE_GROUP) --name $(CLUSTER) --admin --overwrite-existing

.PHONY: azure-inspec-sp
azure-inspec-sp: guard-ENV ## Create Azure Service Principal for Inspec
	@az ad sp create-for-rbac --name=$(AZ_RESOURCE_GROUP)-inspec --scopes="/subscriptions/${AZURE_SUBSCRIPTION_ID}"

# ====================================
# I N S P E C
# ====================================

##@ Inspec

.PHONY: inspec-init
inspec-init: ## Install requirements
	@echo -e "$(OK_COLOR)Install requirements$(NO_COLOR)"
	@PATH=${HOME}/.gem/ruby/2.7.0/bin/:${PATH} bundle install

.PHONY: inspec-test
inspec-test: guard-SERVICE guard-ENV ## Test inspec
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@cd $(SERVICE)/inspec \
		&& $(RUBY_PATH) inspec exec . -t azure:// --input-file=attributes/$(ENV).yml
