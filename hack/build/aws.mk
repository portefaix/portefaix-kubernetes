# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/aws.*.mk

AWS_PROJECT = $(AWS_PROJECT_$(ENV))
AWS_ACCOUNT_ID = $(AWS_ACCOUNT_ID_$(ENV))
AWS_REGION = $(AWS_REGION_$(ENV))
AWS_CLUSTER = $(AWS_CLUSTER_$(ENV))
AWS_ROLE = Administrator

# Tags: tags/x.x.x.x
# Branch: heads/x.x.x.x
INSPEC_PORTEFAIX_AWS_VERSION = tags/v0.1.0
INSPEC_PORTEFAIX_AWS = https://github.com/portefaix/portefaix-inspec-aws/archive/refs/$(INSPEC_PORTEFAIX_AWS_VERSION).zip

# ====================================
# A W S
# ====================================

##@ AWS

.PHONY: aws-admin
aws-admin: guard-ENV ## Generate credentials
	@echo source ./hack/scripts/aws-auth.sh $(AWS_ACCOUNT_ID) $(AWS_ROLE) $(AWS_CLUSTER) $(AWS_REGION)

.PHONY: aws-kube-credentials
aws-kube-credentials: guard-ENV ## Generate credentials
	@aws eks update-kubeconfig --name $(AWS_CLUSTER) --region $(AWS_REGION)

.PHONY: aws-assume-role
aws-assume-role: guard-ENV ## Assume role

.PHONY: aws-secret-version-create
aws-secret-version-create: guard-ENV guard-VERSION # Generate secret
	@echo -e "$(INFO_COLOR)Create the secret for Portefaix version into $(AWS_PROJECT)$(NO_COLOR)"
	@aws secretsmanager create-secret --name portefaix-version \
    	--description "Portefaix version" \
		--tags Key=project,Value=portefaix \
		--tags Key=env,Value=staging \
		--tags Key=service,Value=secrets \
		--tags Key=made-by,Value=awscli \
	    --secret-string $(VERSION)

.PHONY: aws-secret-version-update
aws-secret-version-update: guard-ENV guard-VERSION # Update secret
	@echo -e "$(INFO_COLOR)Update the secret for Portefaix version into $(AWS_PROJECT)$(NO_COLOR)"
	@aws secretsmanager update-secret --secret-id portefaix-version \
		--secret-string $(VERSION)

# ====================================
# S O P S
# ====================================

# ##@ Sops

# .PHONY: aws-sops-encrypt
# aws-sops-encrypt: guard-ENV guard-CLOUD guard-FILE ## Encrypt (CLOUD=xxx ENV=xxx FILE=xxx)
# 	aws sts assume-role --role-arn "$(SOPS_ROLE)" --role-session-name aws-portefaix-$(ENV) \
# 		&& sops --encrypt --encrypted-regex '^(data|stringData)' --in-place --$(SOPS_PROVIDER) $(SOPS_KEY) $(FILE)
