# Copyright (C) 2020-2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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
	@rm -fr vendor
	@rm -fr venv

.PHONY: check
check: check-kubectl check-kustomize check-helm check-flux check-conftest check-kubeval check-popeye ## Check requirements

.PHONY: init
init: ## Initialize environment
	@poetry install

.PHONY: doc
doc: ## Generate documentation
	@echo -e "$(OK_COLOR)[$(APP)] Documentation$(NO_COLOR)"
	@. $(PYTHON_VENV)/bin/activate && mkdocs serve

.PHONY: diagrams
diagrams: guard-CLOUD_PROVIDER guard-OUTPUT ## Generate diagrams
	@poetry run python3 diagrams/kubernetes.py --output=$(OUTPUT) --cloud=$(CLOUD_PROVIDER) \
		&& mv *.$(OUTPUT) docs/img \
		&& poetry run python3 diagrams/portefaix.py --output=$(OUTPUT) --cloud=$(CLOUD_PROVIDER) \
		&& mv *.$(OUTPUT) docs/img

.PHONY: validate
validate: ## Execute git-hooks
	@pre-commit run -a

# ====================================
# T E R R A F O R M
# ====================================

##@ Terraform

.PHONY: terraform-init
terraform-init: guard-SERVICE guard-ENV ## Plan infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Init infrastructure$(NO_COLOR)"
	@cd $(SERVICE)/terraform \
		&& terraform init -upgrade -reconfigure -backend-config=backend-vars/$(ENV).tfvars

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

.PHONY: terraform-tflint
terraform-tflint: guard-SERVICE ## Lint Terraform files
	@echo -e "$(OK_COLOR)[$(APP)] Lint Terraform code$(NO_COLOR)"
	@cd $(SERVICE)/terraform \
		&& tflint \
		--enable-rule=terraform_deprecated_interpolation \
		--enable-rule=terraform_deprecated_index \
		--enable-rule=terraform_unused_declarations \
		--enable-rule=terraform_comment_syntax \
		--enable-rule=terraform_documented_outputs \
		--enable-rule=terraform_documented_variables \
		--enable-rule=terraform_typed_variables \
		--enable-rule=terraform_naming_convention \
		--enable-rule=terraform_required_version \
		--enable-rule=terraform_required_providers \
		--enable-rule=terraform_unused_required_providers \
		--enable-rule=terraform_standard_module_structure

.PHONY: terraform-tfsec
terraform-tfsec: guard-SERVICE ## Scan Terraform files
	@echo -e "$(OK_COLOR)[$(APP)] Lint Terraform code$(NO_COLOR)"
	@cd $(SERVICE)/terraform \
		&& tfsec \

.PHONY: terraform-docs
terraform-docs: guard-SERVICE ## Generate documentation
	@echo -e "$(OK_COLOR)[$(APP)] Lint Terraform code$(NO_COLOR)"
	@cd $(SERVICE)/terraform \
		&& terraform-docs markdown . > README.md


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
kubernetes-secret: guard-NAMESPACE guard-NAME guard-FILE ## Generate a Kubernetes secret file (NAME=xxxx NAMESPACE=xxxx FILE=xxxx)
	@kubectl create secret generic $(NAME) -n $(NAMESPACE) --dry-run=client --from-file=$(FILE) -o yaml

.PHONY: kubernetes-sealed-secret
kubernetes-sealed-secret: guard-FILE ## Sealed secret
	kubeseal --format=yaml --cert=$(CERT) < $(FILE) > $$(dirname $(FILE))/$$(basename -s .yaml $(FILE))-sealed.yaml

.PHONY: kubernetes-credentials
kubernetes-credentials: guard-ENV guard-CLOUD ## Generate credentials (CLOUD=xxxx ENV=xxx)
	make -f hack/$(CLOUD).mk $(CLOUD)-kube-credentials ENV=$(ENV)

# ====================================
# H E L M
# ====================================

##@ Helm

.PHONY: helm-terraform-repo
helm-terraform-repo: guard-SERVICE guard-ENV ## Configure Helm repository and chart
	@echo -e "$(OK_COLOR)[$(APP)] Helm repository and chart $(SERVICE):$(ENV)$(NO_COLOR)"
	@. $(SERVICE)/chart.sh $(SERVICE)/terraform/tfvars/$(ENV).tfvars \
		&& helm repo add $${CHART_REPO_NAME} $${CHART_REPO_URL} --force-update \
		&& helm repo update

.PHONY: helm-terraform-values
helm-terraform-values: guard-SERVICE guard-ENV ## Display Helm values
	@echo -e "$(OK_COLOR)[$(APP)] Helm chart values $(SERVICE):$(ENV)$(NO_COLOR)"
	@. $(SERVICE)/chart.sh $(SERVICE)/terraform/tfvars/$(ENV).tfvars \
		&& helm show values $${CHART_REPO_NAME}/$${CHART_NAME} --version $${CHART_VERSION}

.PHONY: helm-terraform-template
helm-terraform-template: guard-SERVICE guard-ENV ## Helm chart rendering
	@echo -e "$(OK_COLOR)[$(APP)] Validate Helm chart $(SERVICE):$(ENV)$(NO_COLOR)"
	@. $(SERVICE)/chart.sh $(SERVICE)/terraform/tfvars/$(ENV).tfvars \
		&& helm template $${CHART_REPO_NAME}/$${CHART_NAME} \
		-f $(SERVICE)/terraform/tfvars/values.yaml \
		-f $(SERVICE)/terraform/tfvars/$(ENV)-values.yaml

.PHONY: helm-terraform-policy
helm-terraform-policy: guard-SERVICE guard-ENV guard-POLICY ## Validate Helm chart
	@echo -e "$(OK_COLOR)[$(APP)] Validate Helm chart $(SERVICE):$(ENV)$(NO_COLOR)"
	@. $(SERVICE)/chart.sh $(SERVICE)/terraform/tfvars/$(ENV).tfvars \
		&& helm template $${CHART_REPO_NAME}/$${CHART_NAME} \
		-f $(SERVICE)/terraform/tfvars/values.yaml \
		-f $(SERVICE)/terraform/tfvars/$(ENV)-values.yaml | conftest test -p $(POLICY) --all-namespaces -

.PHONY: helm-flux-repo
helm-flux-repo: guard-SERVICE guard-ENV ## Configure Helm repository and chart
	@echo -e "$(OK_COLOR)[$(APP)] Helm repository and chart $(SERVICE):$(ENV)$(NO_COLOR)"
	@export BASE=$$(echo $(SERVICE) | sed -e "s/$(ENV)/base/g") \
		&& . $${BASE}/chart.sh $${BASE}/$$(basename $(SERVICE).yaml) \
		&& helm repo add $${CHART_REPO_NAME} $${CHART_REPO_URL} --force-update \
		&& helm repo update

.PHONY: helm-flux-values
helm-flux-values: guard-SERVICE guard-ENV ## Display Helm values
	@echo -e "$(OK_COLOR)[$(APP)] Helm repository and chart $(SERVICE):$(ENV)$(NO_COLOR)"
	@export BASE=$$(echo $(SERVICE) | sed -e "s/$(ENV)/base/g") \
		&& . $${BASE}/chart.sh $${BASE}/$$(basename $(SERVICE).yaml) \
		&& helm show values $${CHART_REPO_NAME}/$${CHART_NAME} --version $${CHART_VERSION}

.PHONY: helm-flux-template
helm-flux-template: guard-SERVICE guard-ENV ## Install Helm chart (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Build Helm chart ${SERVICE}:${ENV}$(NO_COLOR)"
	@export BASE=$$(echo $(SERVICE) | sed -e "s/$(ENV)/base/g") \
		&& . $${BASE}/chart.sh $${BASE}/$$(basename $(SERVICE).yaml) \
		&& export TMPFILE=$$(./hack/scripts/flux-helm.sh $(SERVICE) $(ENV)) \
		&& helm template $${CHART_NAME} $${CHART_REPO_NAME}/$${CHART_NAME} --namespace $${CHART_NAMESPACE} -f $${TMPFILE}

.PHONY: helm-flux-install
helm-flux-install: guard-SERVICE guard-ENV ## Install Helm chart (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Install Helm chart ${SERVICE}:${ENV}$(NO_COLOR)"
	@export BASE=$$(echo $(SERVICE) | sed -e "s/$(ENV)/base/g") \
		&& . $${BASE}/chart.sh $${BASE}/$$(basename $(SERVICE).yaml) \
		&& export TMPFILE=$$(./hack/scripts/flux-helm.sh $(SERVICE) $(ENV)) \
		&& echo helm install $${CHART_NAME} $${CHART_REPO_NAME}/$${CHART_NAME} --namespace $${CHART_NAMESPACE} -f $${TMPFILE}


# .PHONY: helm-flux-policy
# helm-flux-policy: guard-SERVICE guard-ENV ## Display Helm values
# 	@echo -e "$(OK_COLOR)[$(APP)] Helm repository and chart $(SERVICE):$(ENV)$(NO_COLOR)"
# 	export BASE=$$(echo $(SERVICE) | sed -e "s/$(ENV)/base/g") \
# 		&& . $${BASE}/chart.sh $${BASE}/$$(basename $(SERVICE).yaml) \
# 		&& helm template $${CHART_REPO_NAME}/$${CHART_NAME} \


# ====================================
# O P A
# ====================================

##@ Opa

.PHONY: opa-deps
opa-deps: ## Setup OPA dependencies
	@echo -e "$(OK_COLOR)[$(APP)] Install OPA policy $(POLICY)$(NO_COLOR)"
	@conftest pull --policy addons/policies/deprek8ion github.com/swade1987/deprek8ion//policies
	@conftest pull --policy addons/policies/portefaix github.com/nlamirault/portefaix-policies//policy

.PHONY: opa-install
opa-install: guard-NAME guard-URL ## Install OPA policies
	@echo -e "$(OK_COLOR)[$(APP)] Install OPA policy $(POLICY)$(NO_COLOR)"
	conftest pull --policy addons/policies/$(NAME) $(URL)

# ====================================
# I N S P E C
# ====================================

##@ Inspec

.PHONY: inspec-deps
inspec-deps: ## Install requirements
	@echo -e "$(OK_COLOR)Install requirements$(NO_COLOR)"
	@PATH=${HOME}/.gem/ruby/2.7.0/bin/:${PATH} bundle config set path vendor/bundle --local \
		&& PATH=${HOME}/.gem/ruby/2.7.0/bin/:${PATH} bundle install


# ====================================
# S O P S
# ====================================

##@ Sops

.PHONY: sops-gpg-create
sops-gpg-create: ## Create an OpenGPG key
	@GNUPGHOME=$(MKFILE_DIR)../../$(APP)/.gnupg gpg --full-generate-key

.PHONY: sops-gpg-list
sops-gpg-list: ## List OpenPPG secret keys
	@GNUPGHOME=$(MKFILE_DIR)../../$(APP)/.gnupg gpg --list-secret-keys

.PHONY: sops-encrypt
sops-encrypt: guard-ENV guard-CLOUD guard-FILE ## Encrypt a Kubernetes secret file (CLOUD=xxx ENV=xxx FILE=xxx)
	@GNUPGHOME=$(MKFILE_DIR)../../$(APP)/.gnupg sops --encrypt --encrypted-regex '^(data|stringData)' --in-place --$(SOPS_PROVIDER) $(SOPS_KEY) $(FILE)

.PHONY: sops-encrypt-raw
sops-encrypt-raw: guard-ENV guard-CLOUD guard-FILE ## Encrypt raw file (CLOUD=xxx ENV=xxx FILE=xxx)
	@GNUPGHOME=$(MKFILE_DIR)../../$(APP)/.gnupg sops --encrypt --$(SOPS_PROVIDER) $(SOPS_KEY) $(FILE)

.PHONY: sops-decrypt
sops-decrypt: guard-FILE ## Decrypt
	@GNUPGHOME=$(MKFILE_DIR)../../$(APP)/.gnupg sops --decrypt $(FILE)


# ====================================
# G I T O P S
# ====================================

##@ Gitops

.PHONY: gitops-bootstrap
gitops-bootstrap: guard-ENV guard-CLOUD guard-BRANCH kubernetes-check-context ## Bootstrap Flux v2
	./hack/scripts/bootstrap.sh clusters/$(CLOUD)/$(ENV) $(BRANCH)
