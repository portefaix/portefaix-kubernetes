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
include $(MKFILE_DIR)/exoscale.*.mk

EXO_PROJECT = $(EXO_PROJECT_$(ENV))
EXO_REGION  = $(EXO_REGION_$(ENV))

CLUSTER     = $(EXO_CLUSTER_$(ENV))

BUNDLE_PATH=$(DIR)/vendor/bundle/ruby/2.7.0/bin


# ====================================
# E X O S C A L E
# ====================================

##@ Exoscale

.PHONY: exo-kube-credentials
exo-kube-credentials: guard-ENV ## Generate credentials
	exo sks kubeconfig $(CLUSTER) admin -g system:masters > /tmp/exo-$(CLUSTER)

.PHONY: exo-bucket
exo-bucket: guard-ENV ## Setup the bucket for Terraform states
	@echo -e "$(INFO_COLOR)Create the bucket for Terraform tfstates$(NO_COLOR)"
	exo storage mb sos://$(EXO_PROJECT)-tfstates --acl private


# ====================================
# I N S P E C
# ====================================

##@ Inspec

.PHONY: inspec-cis-kubernetes
inspec-cis-kubernetes: guard-ENV ## Test inspec
	@echo -e "$(OK_COLOR)CIS Kubernetes benchmark$(NO_COLOR)"
	@bundle exec inspec exec \
		https://github.com/dev-sec/cis-kubernetes-benchmark.git \
		--reporter cli json:$(AZ_RESOURCE_GROUP).json
