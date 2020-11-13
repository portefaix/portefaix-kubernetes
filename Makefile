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

include commons.mk
# -include local.*.mk
# -include gcp.*.mk
# -include aws.*.mk
# -include azure.*.mk

BANNER = P O R T E F A I X / K 8 S

DEBUG ?=

# SHELL = /bin/bash -o pipefail

# DIR = $(shell pwd)

ENVS = $(shell ls *.*.mk | awk -F"." '{ print $$2 }')

ANSIBLE_VENV = $(DIR)/venv

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
# T E R R A F O R M
# ====================================

##@ Terraform

.PHONY: terraform-plan
terraform-plan: guard-SERVICE guard-ENV guard-GOOGLE_APPLICATION_CREDENTIALS ## Plan infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Plan infrastructure$(NO_COLOR)"
	@cd $(SERVICE)/terraform \
		&& terraform init -reconfigure -backend-config=backend-vars/$(ENV).tfvars \
		&& terraform plan -var-file=tfvars/$(ENV).tfvars

.PHONY: terraform-apply
terraform-apply: guard-SERVICE guard-ENV guard-GOOGLE_APPLICATION_CREDENTIALS ## Builds or changes infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Apply infrastructure$(NO_COLOR)"
	@cd $(SERVICE)/terraform \
		&& terraform init -reconfigure -backend-config=backend-vars/$(ENV).tfvars \
		&& terraform apply -var-file=tfvars/$(ENV).tfvars

.PHONY: terraform-destroy
terraform-destroy: guard-SERVICE guard-ENV ## Builds or changes infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Apply infrastructure$(NO_COLOR)"
	@cd $(SERVICE)/terraform \
		&& terraform init -lock-timeout=60s -reconfigure -backend-config=backend-vars/$(ENV).tfvars \
		&& terraform destroy -lock-timeout=60s -var-file=tfvars/$(ENV).tfvars


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
kubernetes-secret: guard-CERT guard-FILE ## Generate a secret
	kubeseal --format=yaml --cert=$(CERT) < $(FILE) > $$(dirname $(FILE))/$$(basename -s .yaml $(FILE))-sealed.yaml


# ====================================
# G I T O P S
# ====================================

##@ Gitops

.PHONY: gitops-bootstrap
gitops-bootstrap: guard-ENV kubernetes-check-context ## Bootstrap Flux v2
	@./hack/bootstrap.sh $(ENV)


.PHONY: gitops-init
gitops-init: guard-ENV kubernetes-check-context ## Initialize a cluster
	@kubectl apply -f envs/$(ENV)
