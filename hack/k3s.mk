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
include $(MKFILE_DIR)/k3s.*.mk

PYTHON = python3
ANSIBLE_VERSION = 3.2.0
MOLECULE_VERSION = 3.3.0
ANSIBLE_VENV = $(DIR)/venv
ANSIBLE_ROLES = $(DIR)/roles


# ====================================
# K 3 S
# ====================================

##@ K3s

# .PHONY: k3s-create
# k3s-create: guard-ENV ## Creates a local Kubernetes cluster
# 	@echo -e "$(OK_COLOR)[$(APP)] Create Kubernetes cluster ${SERVICE}$(NO_COLOR)"


# .PHONY: k3s-delete
# k3s-delete: guard-ENV ## Delete a local Kubernetes cluster
# 	@echo -e "$(OK_COLOR)[$(APP)] Create Kubernetes cluster ${SERVICE}$(NO_COLOR)"

.PHONY: k3s-kube-credentials
k3s-kube-credentials: guard-ENV ## Credentials for k3s (ENV=xxx)
	@kubectl config use-context $(KUBE_CONTEXT)


# ====================================
# P G P
# ====================================

##@ PGP

.PHONY: pgp-create
pgp-create: guard-CLOUD guard-ENV ## Create a PGP key
	@echo -e "$(OK_COLOR)[$(APP)] Create a PGP key ${SERVICE}$(NO_COLOR)"
	@./hack/scripts/gpg.sh $(CLOUD) $(ENV)

.PHONY: pgp-secret
pgp-secret: guard-CLOUD guard-ENV ## Create the Kubernetes secret using PGP key
	@echo -e "$(OK_COLOR)[$(APP)] Create Kubernetes secret for PGP key ${SERVICE}$(NO_COLOR)"
	@kubectl create secret generic sops-gpg \
		--namespace=flux-system \
		--from-file=sops.asc=.secrets/$(CLOUD)/$(ENV)/gpg/sops.asc


# ====================================
# A N S I B L E
# ====================================

##@ Ansible

.PHONY: ansible-init
ansible-init: ## Install requirements
	@echo -e "$(OK_COLOR)[$(APP)] Install requirements$(NO_COLOR)"
	@test -d $(ANSIBLE_VENV) || $(PYTHON) -m venv $(ANSIBLE_VENV)
	@. $(ANSIBLE_VENV)/bin/activate \
		&& pip3 install ansible==$(ANSIBLE_VERSION) molecule==$(MOLECULE_VERSION) docker

.PHONY: ansible-deps
ansible-deps: guard-SERVICE ## Install dependencies (SERVICE=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Install dependencies$(NO_COLOR)"
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ansible-galaxy collection install -r $(SERVICE)/roles/requirements.yml -p $(ANSIBLE_ROLES) --force \
		&& cd $(SERVICE) && git clone https://github.com/rancher/k3s-ansible \
		&& cp -r k3s-ansible/roles roles/rancher \
		&& rm -fr k3s-ansible

.PHONY: ansible-ping
ansible-ping: guard-SERVICE guard-ENV ## Check Ansible installation (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Check Ansible$(NO_COLOR)"
	@ansible -c local -m ping all -i $(SERVICE)/inventories/$(ENV).ini

.PHONY: ansible-debug
ansible-debug: guard-SERVICE guard-ENV ## Retrieve informations from hosts (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Check Ansible$(NO_COLOR)"
	@ansible -m setup all -i $(SERVICE)/inventories/$(ENV).ini

.PHONY: ansible-run
ansible-run: guard-SERVICE guard-ENV ## Execute Ansible playbook (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Execute Ansible playbook$(NO_COLOR)"
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ansible-playbook ${DEBUG} -i $(SERVICE)/inventories/$(ENV).ini $(SERVICE)/main.yml

.PHONY: ansible-dryrun
ansible-dryrun: guard-SERVICE guard-ENV ## Execute Ansible playbook (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Execute Ansible playbook$(NO_COLOR)"
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ansible-playbook ${DEBUG} -i $(SERVICE)/inventories/$(ENV).ini $(SERVICE)/main.yml --check
