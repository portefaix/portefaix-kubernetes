# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

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
INFO_COLOR=\033[34;01m
WHITE_COLOR=\033[1m

MAKE_COLOR=\033[33;01m%-20s\033[0m

.DEFAULT_GOAL := help

OK=[✅]
KO=[❌]
WARN=[🟡]

.PHONY: help
help:
	@echo -e "$(OK_COLOR)                 $(BANNER)$(NO_COLOR)"
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
