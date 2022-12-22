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
include $(MKFILE_DIR)/vultr.*.mk

VULTR_REGION = $(VULTR_REGION_$(ENV))

VULTR_CLUSTER = $(VULTR_CLUSTER_$(ENV))

# ====================================
# V U L T R
# ====================================

##@ Vultr

.PHONY: vultr-kube-credentials
vultr-kube-credentials: guard-ENV ## Generate credentials
	@export K8S_ID=$$(vultr-cli kubernetes list | grep -B 1 $(VULTR_CLUSTER) | head -n 1 | awk -F" " '{ print $$2 }') \
		&& vultr-cli kubernetes config $${K8S_ID} | base64 -d
