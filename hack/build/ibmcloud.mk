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
