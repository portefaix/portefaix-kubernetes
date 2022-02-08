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
include $(MKFILE_DIR)/oci.*.mk

OCI_COMPARTMENT_NAME = $(OCI_COMPARTMENT_NAME_$(ENV))

OCI_REGION = $(OCI_REGION_$(ENV))

# ====================================
# O C I
# ====================================

##@ OCI

.PHONY: oci-compartment
oci-compartment: guard-ENV ## Create compartment
	@echo -e "$(OK_COLOR)[$(APP)] Create compartment$(NO_COLOR)"
	@oci iam compartment create \
		--compartment-id "${OCI_COMPARTMENT_PARENT_ID}" \
		--name "$(OCI_COMPARTMENT_NAME)" \
		--description "Created by OCI CLI" \
		--freeform-tags '{"Project": "Portefaix", "Env": "$(ENV)", "Made-By": "OCI CLI"}'

.PHONY: oci-bucket
oci-bucket: guard-ENV guard-COMPARTMENT_ID ## Create bucket for bootstrap
	@echo -e "$(OK_COLOR)[$(APP)] Create bucket for bootstrap$(NO_COLOR)"
	@oci os bucket create \
		--compartment-id "$(COMPARTMENT_ID)" \
		--name "$(OCI_COMPARTMENT_NAME)-tfstates" \
		--region $(OCI_REGION) \
		--public-access-type NoPublicAccess \
		--storage-tier Standard \
		--freeform-tags '{"Project": "Portefaix", "Env": "$(ENV)", "Made-By": "OCI CLI"}'
