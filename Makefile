# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

-include *.mk

BANNER = P O R T E F A I X / L A B

APP = portefaix-lab

DEBUG ?=

SHELL = /bin/bash -o pipefail

DIR = $(shell pwd)

# ENVS = $(shell find iac -name "*.mk" | awk -F"." '{ print $$1 $$2 }')

CONFIG_HOME = $(or ${XDG_CONFIG_HOME},${XDG_CONFIG_HOME},${HOME}/.config)

GCP_CURRENT_PROJECT = $(shell gcloud info --format='value(config.project)')
GCP_REGION = $(GCP_REGION_$(ENV))

CLUSTER = $(CLUSTER_$(ENV))

KUBE_CONTEXT = $(KUBE_CONTEXT_$(ENV))
KUBE_CURRENT_CONTEXT = $(shell kubectl config current-context)

GOTK_VERSION = latest

ANSIBLE_VENV = $(DIR)/venv

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
	@echo -e "${ERROR_COLOR}Environments${NO_COLOR}: $(ENVS)"
	@awk 'BEGIN {FS = ":.*##"; } /^[a-zA-Z_-]+:.*?##/ { printf "  ${INFO_COLOR}%-25s${NO_COLOR} %s\n", $$1, $$2 } /^##@/ { printf "\n${WHITE_COLOR}%s${NO_COLOR}\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""


guard-%:
	@if [ "${${*}}" = "" ]; then \
		echo -e "$(ERROR_COLOR)Environment variable $* not set$(NO_COLOR)"; \
		exit 1; \
	fi

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

# ====================================
# D E V E L O P M E N T
# ====================================

##@ Development

.PHONY: clean
clean: ## Cleanup
	@echo -e "$(OK_COLOR)[$(BANNER)] Cleanup$(NO_COLOR)"
	@find . -name "*.retry"|xargs rm -f

.PHONY: check
check: check-kubectl check-kustomize check-helm check-flux check-conftest check-kubeval check-popeye ## Check requirements



# ====================================
# D O C U M E N T A T I O N
# ====================================

##@ Documentation

.PHONY: doc-init
doc-init: ## Initialize documentation dependencies
	@echo -e "$(OK_COLOR)[$(APP)] Install requirements$(NO_COLOR)"
	@test -d $(ANSIBLE_VENV) || python3 -m venv $(ANSIBLE_VENV)
	@. $(ANSIBLE_VENV)/bin/activate && pip3 install mkdocs mkdocs-material

.PHONY: doc-build
doc-build: ## Generate documentation
	@echo -e "$(OK_COLOR)[$(APP)] Documentation$(NO_COLOR)"
	@. $(ANSIBLE_VENV)/bin/activate && mkdocs serve


# ====================================
# D I A G R A M S
# ====================================

##@ Diagrams

.PHONY: diagrams-init
diagrams-init: ## Initialize diagrams
	@echo -e "$(OK_COLOR)[$(APP)] Install requirements$(NO_COLOR)"
	@test -d $(ANSIBLE_VENV) || python3 -m venv $(ANSIBLE_VENV)
	@. $(ANSIBLE_VENV)/bin/activate && pip3 install diagrams

.PHONY: diagrams-generate
diagrams-generate: guard-SERVICE guard-CLOUD_PROVIDER ## Generate diagrams
	@. $(ANSIBLE_VENV)/bin/activate \
		&& python3 $(SERVICE)/doc.py --output=png --cloud=$(CLOUD_PROVIDER) \
		&& mv *.png docs/img \

# ====================================
# K I N D
# ====================================

##@ Kind

.PHONY: kind-create
kind-create: guard-ENV ## Creates a local Kubernetes cluster
	@echo -e "$(OK_COLOR)[$(APP)] Create Kubernetes cluster ${SERVICE}$(NO_COLOR)"
	kind create cluster --name=$(CLUSTER) --config=iac/local/kind-config.yaml --wait 180s

.PHONY: kind-delete
kind-delete: guard-ENV ## Creates a local Kubernetes cluster
	@echo -e "$(OK_COLOR)[$(APP)] Create Kubernetes cluster ${SERVICE}$(NO_COLOR)"
	kind delete cluster --name=$(CLUSTER)


# ====================================
# K U B E R N E T E S
# ====================================

##@ Kubernetes

kubernetes-check-context:
	@if [[ "${KUBE_CONTEXT}" != "${KUBE_CURRENT_CONTEXT}" ]] ; then \
		echo -e "$(ERROR_COLOR)[KO]$(NO_COLOR) Kubernetes context: ${KUBE_CONTEXT} vs ${KUBE_CURRENT_CONTEXT}"; \
		exit 1; \
	fi

.PHONY: kubernetes-switch
kubernetes-switch: guard-ENV ## Switch Kubernetes context
	@kubectl config use-context $(KUBE_CONTEXT)

.PHONY: kubernetes-secret
kubernetes-secret: guard-ENV guard-CERT guard-FILE ## Generate a secret
	kubeseal --format=yaml --cert=$(CERT) < $(FILE) > $$(basename -s .yaml $(FILE))-sealed.yaml


# ====================================
# G I T O P S
# ====================================

##@ GitopsToolkit

.PHONY: flux-bootstrap
flux-bootstrap: guard-ENV kubernetes-check-context ## Bootstrap a cluster
	@flux bootstrap github \
		--components=source-controller,kustomize-controller,helm-controller,notification-controller \
		--path=kubernetes/ \
		--version=$(GOTK_VERSION) \
		--owner=$${GITHUB_USERNAME} \
		--repository=$(APP) \
		--branch=master \
		--personal
