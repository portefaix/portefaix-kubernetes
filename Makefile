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

include hack/commons.mk
-include hack/$(CLOUD).$(ENV).mk

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

.PHONY: init
init:
	poetry init


# ====================================
# D O C U M E N T A T I O N
# ====================================

##@ Documentation

# .PHONY: doc-init
# doc-init: ## Initialize documentation dependencies
# 	@echo -e "$(OK_COLOR)[$(APP)] Install requirements$(NO_COLOR)"
# 	@test -d $(ANSIBLE_VENV) || python3 -m venv $(ANSIBLE_VENV)
# 	@. $(ANSIBLE_VENV)/bin/activate && pip3 install mkdocs mkdocs-material

.PHONY: doc-build
doc-build: ## Generate documentation
	@echo -e "$(OK_COLOR)[$(APP)] Documentation$(NO_COLOR)"
	@. $(ANSIBLE_VENV)/bin/activate && mkdocs serve


# ====================================
# D I A G R A M S
# ====================================

##@ Diagrams

.PHONY: diagrams-generate
diagrams-generate: guard-CLOUD_PROVIDER ## Generate diagrams
	@poetry run python3 diagrams/kubernetes.py --output=png --cloud=$(CLOUD_PROVIDER) \
		&& mv *.png docs/img \
		&& poetry run python3 diagrams/portefaix.py --output=png --cloud=$(CLOUD_PROVIDER) \
		&& mv *.png docs/img

# ====================================
# T E R R A F O R M
# ====================================

##@ Terraform

.PHONY: terraform-init
terraform-init: guard-SERVICE guard-ENV ## Plan infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Init infrastructure$(NO_COLOR)"
	@cd $(SERVICE)/terraform \
		&& terraform init -reconfigure -backend-config=backend-vars/$(ENV).tfvars

.PHONY: terraform-plan
terraform-plan: guard-SERVICE guard-ENV ## Plan infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Plan infrastructure$(NO_COLOR)"
	@cd $(SERVICE)/terraform \
		&& terraform init -reconfigure -backend-config=backend-vars/$(ENV).tfvars \
		&& terraform plan -var-file=tfvars/$(ENV).tfvars

.PHONY: terraform-apply
terraform-apply: guard-SERVICE guard-ENV ## Builds or changes infrastructure (SERVICE=xxx ENV=xxx)
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
	@if [[ "$(KUBE_CONTEXT)" != "$(KUBE_CURRENT_CONTEXT)" ]] ; then \
		echo -e "$(ERROR_COLOR)[KO]$(NO_COLOR) Kubernetes context: $(KUBE_CONTEXT) vs $(KUBE_CURRENT_CONTEXT)"; \
		exit 1; \
	fi

.PHONY: kubernetes-switch
kubernetes-switch: guard-ENV ## Switch Kubernetes context (ENV=xxx)
	@kubectl config use-context $(KUBE_CONTEXT)

.PHONY: kubernetes-secret
kubernetes-secret: guard-NAMESPACE guard-NAME guard-FILE ## Generate a secret (CERT=xxxx FILE=xxxx)
	@kubectl create secret generic $(NAME) -n $(NAMESPACE) --dry-run=client --from-file=$(FILE) -o yaml

.PHONY: kubernetes-sealed-secret
kubernetes-sealed-secret: guard-FILE ## Sealed secret
	kubeseal --format=yaml --cert=$(CERT) < $(FILE) > $$(dirname $(FILE))/$$(basename -s .yaml $(FILE))-sealed.yaml

.PHONY: kubernetes-credentials
kubernetes-credentials: guard-ENV guard-CLOUD ## Generate credentials (CLOUD=xxxx ENV=xxx)
	make -f hack/$(CLOUD).mk $(CLOUD)-kube-credentials ENV=$(ENV)


# ====================================
# I N S P E C
# ====================================

##@ Inspec

.PHONY: inspec-deps
inspec-deps: ## Install requirements
	@echo -e "$(OK_COLOR)Install requirements$(NO_COLOR)"
	@PATH=${HOME}/.gem/ruby/2.7.0/bin/:${PATH} bundle config set path vendor/bundle --local \
		&& PATH=${HOME}/.gem/ruby/2.7.0/bin/:${PATH} bundle install

.PHONY: inspec-cis-kubernetes
inspec-cis-kubernetes: guard-ENV ## Test inspec
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@bundle exec inspec exec https://github.com/dev-sec/cis-kubernetes-benchmark \
		--reporter cli json:k8s.json


# ====================================
# S O P S
# ====================================

##@ Sops

.PHONY: sops-encrypt
sops-encrypt: guard-ENV guard-CLOUD
	sops --encrypt --$(SOPS_PROVIDER) $(SOPS_KEY) test.yaml > test.enc.yaml

.PHONY: sops-decrypt
sops-decrypt: guard-ENV
	sops --decrypt test.enc.yaml


# ====================================
# G I T O P S
# ====================================

.PHONY: gitops-bootstrap
gitops-bootstrap: guard-ENV guard-CLOUD guard-BRANCH kubernetes-check-context ## Bootstrap Flux v2
	./hack/scripts/bootstrap.sh clusters/$(CLOUD)/$(ENV) $(BRANCH)
