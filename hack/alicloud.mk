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
include $(MKFILE_DIR)/alicloud.*.mk

ALICLOUD_PROJECT = $(ALICLOUD_PROJECT_$(ENV))

ALIYUNREGION = $(ALIYUNREGION_$(ENV))

ALIYUNCLUSTER = $(ALIYUNCLUSTER_$(ENV))
ALIYUN_CLUSTER_ID = $(ALIYUN_CLUSTER_ID_$(ENV))

BUNDLE_PATH=$(DIR)/vendor/bundle/ruby/2.7.0/bin

# ====================================
# A L I Y U N
# ====================================

##@ Aliyun

.PHONY: aliyun-profile-configure
aliyun-profile-configure: guard-ENV guard-ALICLOUD_ACCESS_KEY guard-ALICLOUD_SECRET_KEY guard-ALICLOUD_REGION ## Configure profile
	@echo -e "$(OK_COLOR)Setup project: $(ALICLOUD_PROJECT)$(NO_COLOR)"
	@aliyun configure set \
		--profile $(ALICLOUD_PROJECT) \
		--mode AK \
		--region $${ALICLOUD_REGION} \
		--access-key-id $${ALICLOUD_ACCESS_KEY} \
		--access-key-secret $${ALICLOUD_SECRET_KEY}
	@aliyun configure list

.PHONY: aliyun-profile-switch
aliyun-profile-switch: guard-ENV ## Switch Aliyun configuration
	@echo -e "$(INFO_COLOR)Setup project: $(ALICLOUD_PROJECT)$(NO_COLOR)"
	@aliyun configure set --profile $(ALICLOUD_PROJECT)
	@aliyun configure list

.PHONY: aliyun-bucket-create
aliyun-bucket-create: guard-ENV ## Create bucket for bootstrap
	@echo -e "$(OK_COLOR)[$(APP)] Create bucket for bootstrap$(NO_COLOR)"
	aliyun oss mb oss://$(ALICLOUD_PROJECT)-tfstates \
		--profile $(ALICLOUD_PROJECT) \
		--region $(ALICLOUD_REGION)

.PHONY: aliyun-tablestore-create
aliyun-tablestore-create: guard-ENV ## Create tablestore instance
	@echo -e "$(OK_COLOR)[$(APP)] Create DynamoDB table$(NO_COLOR)"
	@echo aliyun ots InsertInstance \
		--profile $(ALICLOUD_PROJECT) \
		--InstanceName tfstates \
		--ClusterType SSD \
		--region $(ALICLOUD_REGION) \
		--Description "Instance for Terraform" \
		--endpoint ots.$(ALICLOUD_REGION).aliyuncs.com

.PHONY: aliyun-kube-credentials
aliyun-kube-credentials: guard-ENV ## Generate credentials
	@aliyun cs GET /k8s/$(ALIYUN_CLUSTER_ID)/user_config | jq -r .config | sed -e "s/$(ALIYUN_CLUSTER_ID)/$(ALICLOUD_PROJECT)/g" > alicloud-$(ALICLOUD_PROJECT)

	# | sed -e "s/kubernetes-admin/aliyun-portefaix-$(ENV)/g" > config-$(PROFILE)


# ====================================
# S O P S
# ====================================

# ##@ Sops

# .PHONY: aliyun-sops-encrypt
# aliyun-sops-encrypt: guard-ENV guard-CLOUD guard-FILE ## Encrypt (CLOUD=xxx ENV=xxx FILE=xxx)
# 	alicloud sts assume-role --role-arn "$(SOPS_ROLE)" --role-session-name aliyun-portefaix-$(ENV) \
# 		&& sops --encrypt --encrypted-regex '^(data|stringData)' --in-place --$(SOPS_PROVIDER) $(SOPS_KEY) $(FILE)


# ====================================
# I N S P E C
# ====================================

##@ Inspec

.PHONY: inspec-alicloud-debug
inspec-alicloud-debug: ## Test inspec
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@bundle exec inspec detect -t alicloud://

.PHONY: inspec-alicloud-test
inspec-alicloud-test: guard-SERVICE guard-ENV ## Test inspec
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@bundle exec inspec exec $(SERVICE)/inspec \
		-t alicloud:// --input-file=$(SERVICE)/inspec/attributes/$(ENV).yml \
		--reporter cli json:$(alicloud_PROJECT).json

.PHONY: inspec-alicloud-cis
inspec-alicloud-cis: guard-ENV ## Test inspec
	@echo -e "$(OK_COLOR)CIS alicloud Foundations benchmark$(NO_COLOR)"
	@bundle exec inspec exec \
		https://github.com/mitre/aliyun-foundations-cis-baseline.git \
		-t alicloud:// --reporter cli json:$(alicloud_PROJECT).json

.PHONY: inspec-alicloud-cis-kubernetes
inspec-alicloud-cis-kubernetes: guard-ENV ## Test inspec
	@echo -e "$(OK_COLOR)CIS Kubernetes benchmark$(NO_COLOR)"
	@bundle exec inspec exec \
		https://github.com/dev-sec/cis-kubernetes-benchmark.git \
		--reporter cli json:$(alicloud_PROJECT).json
