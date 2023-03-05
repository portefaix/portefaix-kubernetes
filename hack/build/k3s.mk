# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
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
#
# SPDX-License-Identifier: Apache-2.0

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))
DIR = $(shell pwd)

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/k3s.*.mk

PYTHON = python3

AKEYLESS_PROFILE = $(AKEYLESS_PROFILE_$(ENV))

CLOUDFLARE_BUCKET = $(CLOUDFLARE_BUCKET_$(ENV))
CLOUDFLARE_ACCOUNT = $(CLOUDFLARE_ACCOUNT_$(ENV))


# ====================================
# C L O U D F L A R E
# ====================================

.PHONY: cloudflare-bucket-create
cloudflare-bucket-create: guard-ENV ## Create bucket for Terraform states
	@echo -e "$(OK_COLOR)[$(APP)] Create bucket for Terraform states$(NO_COLOR)"
	@aws s3api create-bucket --bucket $(CLOUDFLARE_BUCKET) \
		--endpoint-url https://$(CLOUDFLARE_ACCOUNT).r2.cloudflarestorage.com \
    	--region auto

# ====================================
# K 3 S
# ====================================

##@ K3s

.PHONY: k3s-config
k3s-config: guard-SERVER_IP guard-USER guard-ENV ## Merge Kubernetes configuration
	@echo -e "$(OK_COLOR)[$(APP)] Kubernetes configuration$(NO_COLOR)"
	@k3sup install --ip $(SERVER_IP) --user $(K3S_USER) \
		--merge --skip-install \
		--local-path $${HOME}/.kube/config \
		--context $(KUBE_CONTEXT)

.PHONY: k3s-kube-credentials
k3s-kube-credentials: guard-ENV ## Credentials for k3s (ENV=xxx)
	@kubectl config use-context $(KUBE_CONTEXT)


# ====================================
# A K E Y L E S S
# ====================================

##@ AKeyless

.PHONY: akeyless-add-secret
akeyless-add-secret: guard-NAME guard-VALUE guard-ENV ## Add a new secret
	@echo -e "$(OK_COLOR)[$(APP)] Akeyless new secret: $(NAME)$(NO_COLOR)"
	akeyless create-secret --name=$(NAME) --value=$(VALUE) \
		--profile=$(AKEYLESS_PROFILE) \
		--tag=homelab --tag=k3s

.PHONY: akeyless-update-secret
akeyless-update-secret: guard-NAME guard-VALUE guard-ENV ## Add a new secret
	@echo -e "$(OK_COLOR)[$(APP)] Akeyless new secret: $(NAME)$(NO_COLOR)"
	akeyless update-secret-val --name=$(NAME) --value=$(VALUE) \
		--profile=$(AKEYLESS_PROFILE)
