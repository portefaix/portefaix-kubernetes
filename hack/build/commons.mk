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

APP = portefaix

BANNER = P O R T E F A I X

# ENVS = $(shell ls *.*.mk | awk -F"." '{ print $$2 }')

KUBE_CONTEXT = $(KUBE_CONTEXT_$(ENV))
KUBE_CURRENT_CONTEXT = $(shell kubectl config current-context)

CLUSTER = $(CLUSTER_$(ENV))

SOPS_PROVIDER = $(SOPS_PROVIDER_$(ENV))
SOPS_KEY = $(SOPS_KEY_$(ENV))

CONFIG_HOME = $(or ${XDG_CONFIG_HOME},${XDG_CONFIG_HOME},${HOME}/.config)

DEBUG ?=

SHELL = /bin/bash -o pipefail

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

PYTHON_VENV = $(MKFILE_DIR)/../.venv

NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m
INFO_COLOR=\033[36m
WHITE_COLOR=\033[1m

MAKE_COLOR=\033[33;01m%-20s\033[0m

.DEFAULT_GOAL := help

OK=[✅]
KO=[❌]
WARN=[⚠️]

.PHONY: help
help:
	@echo -e "$(OK_COLOR)                  $(BANNER)$(NO_COLOR)"
	@echo "------------------------------------------------------------------"
	@echo ""
	@echo -e "${ERROR_COLOR}Usage${NO_COLOR}: make ${INFO_COLOR}<target>${NO_COLOR}"
	@awk 'BEGIN {FS = ":.*##"; } /^[a-zA-Z0-9_-]+:.*?##/ { printf "  ${INFO_COLOR}%-30s${NO_COLOR} %s\n", $$1, $$2 } /^##@/ { printf "\n${WHITE_COLOR}%s${NO_COLOR}\n", substr($$0, 5) } ' $(MAKEFILE_LIST)



# @echo -e "${ERROR_COLOR}Environments${NO_COLOR}: $(ENVS)"
# @echo ""

guard-%:
	@if [ "${${*}}" = "" ]; then \
		echo -e "$(ERROR_COLOR)Environment variable $* not set$(NO_COLOR)"; \
		exit 1; \
	fi

check2-%:
	ifeq (,$(shell which $*))
		$(error "$* binary must be installed")
	endif

check-%:
	@if $$(hash $* 2> /dev/null); then \
		echo -e "$(OK_COLOR)$(OK)$(NO_COLOR) $*"; \
	else \
		echo -e "$(ERROR_COLOR)$(KO)$(NO_COLOR) $*"; \
	fi

print-%:
	@if [ "${$*}" == "" ]; then \
		echo -e "$(ERROR_COLOR)[KO]$(NO_COLOR) $* = ${$*}"; \
	else \
		echo -e "$(OK_COLOR)[OK]$(NO_COLOR) $* = ${$*}"; \
	fi
