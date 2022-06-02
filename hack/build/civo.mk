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
DIR = $(shell pwd)

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/civo.*.mk

CIVO_REGION = $(CIVO_REGION_$(ENV))

CIVO_CLUSTER = $(CIVO_CLUSTER_$(ENV))

# ====================================
# C I V O
# ====================================

##@ Civo

.PHONY: civo-kube-credentials
civo-kube-credentials: guard-ENV ## Generate credentials
	@civo kubernetes config $(CIVO_CLUSTER) --region $(CIVO_REGION) --save --merge
	@kubectl config use-context $(CIVO_CLUSTER)
