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

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/scw.*.mk

SCW_PROJECT = $(SCW_PROJECT_$(ENV))
SCW_REGION  = $(SCW_REGION_$(ENV))
CLUSTER     = $(SCW_CLUSTER_$(ENV))


# ====================================
# S C A L E W A Y
# ====================================

##@ Scaleway

.PHONY: scw-init
scw-init: guard-ENV ## Initialize the Scaleway CLI
	@echo -e "$(INFO_COLOR)Configure the Scaleway CLI with S3 tools$(NO_COLOR)"
	@scw object config install type=s3cmd

.PHONY: scw-bucket
scw-bucket: guard-ENV ## Setup the bucket for Terraform states
	@echo -e "$(INFO_COLOR)Create the bucket for Terraform tfstates$(NO_COLOR)"
	@s3cmd mb s3://$(SCW_PROJECT)-tfstates

.PHONY: scw-kube-kapsule
scw-kube-kapsule: guard-ENV ## Scaleway Kapsule
	$(eval ID=$(shell scw k8s cluster list -o json | jq -r '.[] | select(.name="$(CLUSTER)") | .id'))
	@scw k8s cluster get $(ID)

.PHONY: scw-kube-credentials
scw-kube-credentials: guard-ENV ## Generate credentials
	$(eval ID=$(shell scw k8s cluster list -o json | jq -r '.[] | select(.name="$(CLUSTER)") | .id'))
	@scw k8s kubeconfig install $(ID)

# ====================================
# I N S P E C
# ====================================

##@ Inspec

.PHONY: inspec-scw-kubernetes
inspec-scw-kubernetes: guard-ENV ## Execute Inspec CIS profile
	@echo -e "$(OK_COLOR)CIS Kubernetes benchmark$(NO_COLOR)"
	@bundle exec inspec exec \
		https://github.com/dev-sec/cis-kubernetes-benchmark.git \
		--reporter cli json:$(SCW_PROJECT).json
