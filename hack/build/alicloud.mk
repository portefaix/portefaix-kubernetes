# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

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
