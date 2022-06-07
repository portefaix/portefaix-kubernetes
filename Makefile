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

include hack/build/commons.mk
-include hack/build/$(CLOUD).$(ENV).mk

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
	@find . -name "Chart.lock" | xargs rm -f
	@find gitops/argocd -name charts | xargs rm -fr

.PHONY: check
check: check-kubectl check-kustomize check-helm check-flux check-conftest check-kubeval check-popeye ## Check requirements

.PHONY: init
init: ## Initialize environment
	@poetry install --no-root
	@poetry run pre-commit install

.PHONY: doc
doc: ## Generate documentation
	@echo -e "$(OK_COLOR)[$(APP)] Documentation$(NO_COLOR)" >&2
	@. $(PYTHON_VENV)/bin/activate && mkdocs serve

.PHONY: diagrams
diagrams: guard-CLOUD_PROVIDER guard-OUTPUT ## Generate diagrams
	@poetry run python3 diagrams/kubernetes.py --output=$(OUTPUT) --cloud=$(CLOUD_PROVIDER) \
		&& mv *.$(OUTPUT) docs/img \
		&& poetry run python3 diagrams/portefaix.py --output=$(OUTPUT) --cloud=$(CLOUD_PROVIDER) \
		&& mv *.$(OUTPUT) docs/img

.PHONY: validate
validate: ## Execute git-hooks
	@poetry run pre-commit run -a

.PHONY: license
license: guard-ACTION ## Check license (ACTION=xxx : fix or check)
	@docker run -it --rm -v $(shell pwd):/github/workspace ghcr.io/apache/skywalking-eyes/license-eye --config /github/workspace/.licenserc.yaml header $(ACTION)


# ====================================
# T E R R A F O R M
# ====================================

##@ Terraform

.PHONY: terraform-init
terraform-init: guard-SERVICE guard-ENV ## Plan infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Init infrastructure$(NO_COLOR)" >&2
	@cd $(SERVICE)/terraform \
		&& terraform init -upgrade -reconfigure -backend-config=backend-vars/$(ENV).tfvars

.PHONY: terraform-plan
terraform-plan: guard-SERVICE guard-ENV ## Plan infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Plan infrastructure$(NO_COLOR)" >&2
	@cd $(SERVICE)/terraform \
		&& terraform init -upgrade -reconfigure -backend-config=backend-vars/$(ENV).tfvars \
		&& terraform plan -var-file=tfvars/$(ENV).tfvars

.PHONY: terraform-apply
terraform-apply: guard-SERVICE guard-ENV ## Builds or changes infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Apply infrastructure$(NO_COLOR)" >&2
	@cd $(SERVICE)/terraform \
		&& terraform init -upgrade -reconfigure -backend-config=backend-vars/$(ENV).tfvars \
		&& terraform apply -var-file=tfvars/$(ENV).tfvars

.PHONY: terraform-destroy
terraform-destroy: guard-SERVICE guard-ENV ## Builds or changes infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Apply infrastructure$(NO_COLOR)" >&2
	@cd $(SERVICE)/terraform \
		&& terraform init -upgrade -reconfigure -backend-config=backend-vars/$(ENV).tfvars \
		&& terraform destroy -lock-timeout=60s -var-file=tfvars/$(ENV).tfvars

.PHONY: terraform-tflint
terraform-tflint: guard-SERVICE ## Lint Terraform files
	@echo -e "$(OK_COLOR)[$(APP)] Lint Terraform code$(NO_COLOR)" >&2
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
	@echo -e "$(OK_COLOR)[$(APP)] Lint Terraform code$(NO_COLOR)" >&2
	@cd $(SERVICE)/terraform \
		&& tfsec \

.PHONY: tfcloud-validate
tfcloud-validate: guard-SERVICE guard-ENV ## Plan infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Init infrastructure$(NO_COLOR)" >&2
	@cd $(SERVICE)/$(ENV) \
		&& rm -fr .terraform \
		&& terraform init \
		&& terraform validate

.PHONY: tfcloud-init
tfcloud-init: guard-SERVICE guard-ENV ## Plan infrastructure using Terraform Cloud (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Init infrastructure$(NO_COLOR)" >&2
	@cd $(SERVICE)/$(ENV) && terraform init

.PHONY: tfcloud-plan
tfcloud-plan: guard-SERVICE guard-ENV ## Plan infrastructure using Terraform Cloud (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Plan infrastructure$(NO_COLOR)" >&2
	@cd $(SERVICE)/$(ENV) \
		&& terraform init \
		&& terraform plan

.PHONY: tfcloud-apply
tfcloud-apply: guard-SERVICE guard-ENV ## Apply infrastructure using Terraform Cloud (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Plan infrastructure$(NO_COLOR)" >&2
	@cd $(SERVICE)/$(ENV) \
		&& terraform init \
		&& terraform apply

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

.PHONY: kubernetes-credentials
kubernetes-credentials: guard-ENV guard-CLOUD ## Generate credentials (CLOUD=xxxx ENV=xxx)
	make -f hack/$(CLOUD).mk $(CLOUD)-kube-credentials ENV=$(ENV)


# ====================================
# H E L M
# ====================================

##@ Helm

# .PHONY: helm-terraform-repo
# helm-terraform-repo: guard-SERVICE guard-ENV ## Configure Helm repository and chart
# 	@echo -e "$(OK_COLOR)[$(APP)] Helm repository and chart $(SERVICE):$(ENV)$(NO_COLOR)"
# 	@. $(SERVICE)/chart-fluxcd.sh $(SERVICE)/terraform/tfvars/$(ENV).tfvars \
# 		&& helm repo add $${CHART_REPO_NAME} $${CHART_REPO_URL} --force-update \
# 		&& helm repo update

# .PHONY: helm-terraform-values
# helm-terraform-values: guard-SERVICE guard-ENV ## Display Helm values
# 	@echo -e "$(OK_COLOR)[$(APP)] Helm chart values $(SERVICE):$(ENV)$(NO_COLOR)"
# 	@. $(SERVICE)/chart-fluxcd.sh $(SERVICE)/terraform/tfvars/$(ENV).tfvars \
# 		&& helm show values $${CHART_REPO_NAME}/$${CHART_NAME} --version $${CHART_VERSION}

# .PHONY: helm-terraform-template
# helm-terraform-template: guard-SERVICE guard-ENV ## Helm chart rendering
# 	@echo -e "$(OK_COLOR)[$(APP)] Validate Helm chart $(SERVICE):$(ENV)$(NO_COLOR)"
# 	@. $(SERVICE)/chart-fluxcd.sh $(SERVICE)/terraform/tfvars/$(ENV).tfvars \
# 		&& helm template $${CHART_REPO_NAME}/$${CHART_NAME} \
# 		-f $(SERVICE)/terraform/tfvars/values.yaml \
# 		-f $(SERVICE)/terraform/tfvars/$(ENV)-values.yaml

# .PHONY: helm-terraform-policy
# helm-terraform-policy: guard-SERVICE guard-ENV guard-POLICY ## Validate Helm chart
# 	@echo -e "$(OK_COLOR)[$(APP)] Validate Helm chart $(SERVICE):$(ENV)$(NO_COLOR)"
# 	@. $(SERVICE)/chart-fluxcd.sh $(SERVICE)/terraform/tfvars/$(ENV).tfvars \
# 		&& helm template $${CHART_REPO_NAME}/$${CHART_NAME} \
# 		-f $(SERVICE)/terraform/tfvars/values.yaml \
# 		-f $(SERVICE)/terraform/tfvars/$(ENV)-values.yaml | conftest test -p $(POLICY) --all-namespaces -

.PHONY: helm-flux-chart
helm-flux-chart: guard-CHART ## Display Helm chart informations (CHART=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Helm repository and chart $(CHART)$(NO_COLOR)" >&2
	@DEBUG=true . hack/scripts/chart-fluxcd.sh $(CHART)

.PHONY: helm-flux-repo
helm-flux-repo: guard-CHART ## Configure Helm repository and chart (CHART=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Helm repository and chart $(CHART)$(NO_COLOR)" >&2
	@DEBUG=$(DEBUG) . hack/scripts/chart-fluxcd.sh $(CHART) \
		&& helm repo add $${CHART_REPO_NAME} $${CHART_REPO_URL} --force-update \
		&& helm repo update

.PHONY: helm-flux-values
helm-flux-values: guard-CHART ## Display Helm values (CHART=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Helm show values $(CHART)$(NO_COLOR)" >&2
	@DEBUG=$(DEBUG) . hack/scripts/chart-fluxcd.sh $(CHART) \
		&& helm show values $${CHART_REPO_NAME}/$${CHART_NAME} --version $${CHART_VERSION}

.PHONY: helm-flux-custom
helm-flux-show: guard-CHART guard-CLOUD guard-ENV ## Show Helm chart values set for Flux (CHART=xxx CLOUD=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Build Helm chart ${CHART}:${ENV}$(NO_COLOR)" >&2
	@DEBUG=$(DEBUG) . hack/scripts/chart-fluxcd.sh $(CHART) \
		&& export TMPFILE=$$(./hack/scripts/flux-helm.sh "$(CHART)" "$(CLOUD)/$(ENV)") \
		&& cat $${TMPFILE}

.PHONY: helm-flux-template
helm-flux-template: guard-CHART guard-CLOUD guard-ENV ## Install Helm chart (CHART=xxx CLOUD=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Build Helm chart ${CHART}:${ENV}$(NO_COLOR)" >&2
	@DEBUG=$(DEBUG) . hack/scripts/chart-fluxcd.sh $(CHART) \
		&& export TMPFILE=$$(./hack/scripts/flux-helm.sh "$(CHART)" "$(CLOUD)/$(ENV)") \
		&& helm template --debug $${CHART_NAME} $${CHART_REPO_NAME}/$${CHART_NAME} --namespace $${CHART_NAMESPACE} -f $${TMPFILE}

.PHONY: helm-flux-install
helm-flux-install: guard-CHART guard-CLOUD guard-ENV kubernetes-check-context ## Install Helm chart (CHART=xxx CLOUD=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Install Helm chart ${CHART}:${ENV}$(NO_COLOR)" >&2
	@DEBUG=$(DEBUG) . hack/scripts/chart-fluxcd.sh $(CHART) \
		&& export TMPFILE=$$(./hack/scripts/flux-helm.sh "$(CHART)" "$(CLOUD)/$(ENV)") \
		&& helm install $${CHART_NAME} $${CHART_REPO_NAME}/$${CHART_NAME} --namespace $${CHART_NAMESPACE} -f $${TMPFILE}

.PHONY: helm-flux-upgrade
helm-flux-upgrade: guard-CHART guard-CLOUD guard-ENV kubernetes-check-context ## Upgrade Helm chart (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Upgrade Helm chart ${CHART}:${ENV}$(NO_COLOR)" >&2
	@DEBUG=$(DEBUG) . hack/scripts/chart-fluxcd.sh $(CHART) \
		&& export TMPFILE=$$(./hack/scripts/flux-helm.sh "$(CHART)" "$(CLOUD)/$(ENV)") \
		&& helm upgrade --install $${CHART_NAME} $${CHART_REPO_NAME}/$${CHART_NAME} --namespace $${CHART_NAMESPACE} -f $${TMPFILE}

.PHONY: helm-flux-uninstall
helm-flux-uninstall: guard-CHART guard-CLOUD guard-ENV kubernetes-check-context ## Uninstall Helm chart (CHART=xxx CLOUD=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Uninstall Helm chart ${CHART}:${ENV}$(NO_COLOR)" >&2
	@DEBUG=$(DEBUG) . hack/scripts/chart-fluxcd.sh $(CHART) \
		&& helm uninstall $${CHART_NAME} --namespace $${CHART_NAMESPACE}

.PHONY: helm-argo-repo
helm-argo-repo: guard-CHART ## Configure Helm repository and chart (CHART=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Helm repository and chart $(CHART)$(NO_COLOR)" >&2
	@DEBUG=$(DEBUG) . hack/scripts/chart-argocd.sh $(CHART) \
		&& helm repo add $${CHART_REPO_NAME} $${CHART_REPO_URL} --force-update \
		&& helm repo update

.PHONY: helm-argo-values
helm-argo-values: guard-CHART
	@echo -e "$(OK_COLOR)[$(APP)] Helm show values $(CHART)$(NO_COLOR)" >&2
	@DEBUG=$(DEBUG) . hack/scripts/chart-argocd.sh $(CHART) \
		&& helm show values $${CHART_REPO_NAME}/$${CHART_NAME} --version $${CHART_VERSION}

# .PHONY: helm-argo-template
# helm-argo-template: guard-CHART guard-CLOUD guard-ENV ## Template Helm chart (CHART=xxx CLOUD=xxx ENV=xxx)
# 	@echo -e "$(OK_COLOR)[$(APP)] Build Helm chart ${CHART}:${ENV}$(NO_COLOR)" >&2
# 	@DEBUG=$(DEBUG) . hack/scripts/chart-argocd.sh $(CHART) \
# 		&& export CHART_DIR=$$(dirname $(CHART)) \
# 		&& echo helm template --debug $${CHART_NAME} $${CHART_REPO_NAME}/$${CHART_NAME} \
# 			-f "$${CHART_DIR}/values.yaml" -f "$${CHART_DIR}/values-$(CLOUD)-$(ENV).yaml" -f "$${CHART_DIR}/values-$(CLOUD)-$(ENV)-secret.yaml"

.PHONY: helm-argo-template
helm-argo-template: guard-CHART guard-CLOUD guard-ENV ## Template Helm chart (CHART=xxx CLOUD=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Build Helm chart ${CHART}:${ENV}$(NO_COLOR)" >&2
	@DEBUG=$(DEBUG) pushd $(CHART) > /dev/null \
		&& rm -fr charts Chart.lock \
		&& helm dependency build >&2 \
		&& helm template portefaix . --debug -f ./values.yaml -f "./values-$(CLOUD)-$(ENV).yaml" \
		&& rm -fr Chart.lock charts \
		&& popd > /dev/null

.PHONY: helm-argo-install
helm-argo-install: guard-CHART guard-CLOUD guard-ENV ## Install Helm chart (CHART=xxx CLOUD=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Build Helm chart ${CHART}:${ENV}$(NO_COLOR)" >&2
	@DEBUG=$(DEBUG) pushd $(CHART) > /dev/null \
		&& export NAMESPACE=$$(basename $$(dirname $(CHART))) \
		&& rm -fr charts Chart.lock \
		&& helm dependency build >&2 \
		&& helm upgrade --install portefaix-$(APP) . --debug --namespace $${NAMESPACE} --create-namespace -f ./values.yaml -f "./values-$(CLOUD)-$(ENV).yaml" \
		&& rm -fr Chart.lock charts \
		&& popd > /dev/null


# ====================================
# O P A
# ====================================

##@ Opa

.PHONY: opa-deps
opa-deps: ## Setup OPA dependencies
	@echo -e "$(OK_COLOR)[$(APP)] Install OPA policies $(POLICY)$(NO_COLOR)" >&2
	@conftest pull --policy addons/policies/deprek8ion github.com/swade1987/deprek8ion//policies
	@conftest pull --policy addons/policies/portefaix github.com/portefaix/portefaix-policies?ref=v0.3.0//policy

POHONY: opa-test
opa-test: ## Test policies
	@opa test addons/policies/core

.PHONY: opa-policy
opa-policy-base: guard-CHART guard-ENV guard-POLICY ## Check OPA policies for a Helm chart (CHART=xxx CLOUD=xxx ENV=xxx POLICY=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Open Policy Agent check policies $(CHART):$(ENV)$(NO_COLOR)" >&2
	@DEBUG=$(DEBUG) . hack/scripts/chart-fluxcd.sh $(CHART) \
		&& export TMPFILE=$$(./hack/scripts/flux-helm.sh "$(CHART)" "$(CLOUD)/$(ENV)") \
		&& helm template $${CHART_NAME} $${CHART_REPO_NAME}/$${CHART_NAME} --namespace $${CHART_NAMESPACE} -f $${TMPFILE} | conftest test --all-namespaces -p $(POLICY) -


# ====================================
# I N S P E C
# ====================================

##@ Inspec

.PHONY: inspec-init
inspec-init: ## Install requirements
	@echo -e "$(OK_COLOR)Install requirements$(NO_COLOR)" >&2
	@gem install bundler

.PHONY: inspec-deps
inspec-deps: ## Install dependencies
	@echo -e "$(OK_COLOR)Install requirements$(NO_COLOR)" >&2
	@bundle config set path vendor/bundle --local \
		&& bundle install


# ====================================
# S E C R E T S
# ====================================

##@ Secrets

.PHONY: sops-age-key
sops-age-key: guard-CLOUD guard-ENV ## Create an Age key (CLOUD=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Create an Age key $(NO_COLOR)" >&2
	@mkdir -p .secrets/$(CLOUD)/$(ENV)/age/ \
		&& age-keygen -o .secrets/$(CLOUD)/$(ENV)/age/age.agekey

.PHONY: sops-age-secret
sops-age-secret: guard-CLOUD guard-ENV guard-NAMESPACE kubernetes-check-context ## Create the Kubernetes secret using an AGE key (CLOUD=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Create Kubernetes secret for AGE key $(NO_COLOR)" >&2
	@kubectl create secret generic sops-age \
		--namespace=$(NAMESPACE) \
		--from-file=age.agekey=.secrets/$(CLOUD)/$(ENV)/age/age.agekey

.PHONY: sops-pgp-key
sops-pgp-key: guard-CLOUD guard-ENV ## Create a PGP key (CLOUD=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Create a PGP key $(NO_COLOR)" >&2
	@./hack/scripts/gpg.sh $(CLOUD) $(ENV)

.PHONY: sops-pgp-secret
sops-pgp-secret: guard-CLOUD guard-ENV guard-NAMESPACE  kubernetes-check-context ## Create the Kubernetes secret using a PGP key (CLOUD=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Create Kubernetes secret for PGP key $(NO_COLOR)" >&2
	@kubectl create secret generic sops-gpg \
		--namespace=$(NAMESPACE) \
		--from-file=sops.asc=.secrets/$(CLOUD)/$(ENV)/gpg/sops.asc

.PHONY: sops-encrypt
sops-encrypt: guard-CLOUD guard-ENV guard-FILE ## Encrypt a Kubernetes secret file (CLOUD=xxx ENV=xxx FILE=xxx)
	@sops --encrypt --encrypted-regex '^(data|stringData)' --in-place --$(SOPS_PROVIDER) $(SOPS_KEY) $(FILE)

.PHONY: sops-encrypt-raw
sops-encrypt-raw: guard-CLOUD guard-ENV guard-FILE ## Encrypt raw file (CLOUD=xxx ENV=xxx FILE=xxx)
	@sops --encrypt --$(SOPS_PROVIDER) $(SOPS_KEY) $(FILE)

.PHONY: sops-decrypt
sops-decrypt: guard-CLOUD guard-ENV guard-FILE ## Decrypt (CLOUD=xxx ENV=xxx FILE=xxx)
	@SOPS_AGE_KEY_FILE=.secrets/$(CLOUD)/$(ENV)/age/age.agekey sops --decrypt $(FILE)

# .PHONY: kubeseal-encrypt
# kubeseal-encrypt: guard-CLOUD guard-ENV guard-FILE guard-NAME guard-NAMESPACE ## Encrypt a Kubernetes secret file (CLOUD=xxx ENV=xxx FILE=xxx)
# 	@kubectl create secret -n $(NAMESPACE) generic $(NAME) --dry-run=client -o yaml --from-file=$(FILE) | \
# 		kubeseal --format yaml --cert .secrets/$(CLOUD)/$(ENV)/sealed-secrets/cert.pm

.PHONY: kubeseal-encrypt
kubeseal-encrypt: guard-CLOUD guard-ENV guard-NAMESPACE ## Encrypt data (CLOUD=xxx ENV=xxx DATA=xxx)
	@echo -n "$(DATA)" | kubeseal --raw --from-file=/dev/stdin --scope cluster-wide \
		--scope cluster-wide \
		--controller-namespace kube-system \
		--controller-name sealed-secrets \
		--namespace $(NAMESPACE)

.PHONY: kubeseal-secret
kubeseal-secret: guard-CLOUD guard-ENV guard-FILE guard-NAMESPACE ## Encrypt data (CLOUD=xxx ENV=xxx FILE=xxx)
	@cat $(FILE)| kubeseal --scope cluster-wide \
		--controller-namespace kube-system \
    	--controller-name sealed-secrets \
		--namespace $(NAMESPACE) \
    	--format yaml

#    > sealed-secret.yaml

# ====================================
# G I T O P S
# ====================================

##@ Gitops

.PHONY: release-prepare
release-prepare: guard-VERSION ## Update release label (VERSION=xxx)
	@./hack/scripts/portefaix-labels.sh gitops yaml $(VERSION)
	@./hack/scripts/portefaix-labels.sh krm yaml $(VERSION)
	@./hack/scripts/portefaix-labels.sh terraform tfvars $(VERSION) aws
	@./hack/scripts/portefaix-labels.sh terraform tfvars $(VERSION) azure
	@./hack/scripts/portefaix-labels.sh terraform tfvars $(VERSION) gcp
	# @./hack/scripts/validate.sh clusters kubernetes

.PHONY: fluxcd-bootstrap
fluxcd-bootstrap: guard-ENV guard-CLOUD guard-BRANCH kubernetes-check-context ## Bootstrap FluxCD
	@./hack/scripts/bootstrap-fluxcd.sh $(CLOUD) $(ENV) $(BRANCH)

.PHONY: argocd-bootstrap
argocd-bootstrap: guard-ENV guard-CLOUD guard-CHOICE ## Bootstrap ArgoCD
	@./hack/scripts/bootstrap-argocd.sh $(CLOUD) $(ENV) $(CHOICE)

.PHONY: argocd-stack-install
argocd-stack-install: guard-ENV guard-CLOUD guard-STACK ## Setup ArgoCD applications
	@./hack/scripts/argocd-app.sh $(CLOUD) $(ENV) $(STACK) install

.PHONY: argocd-stack-build
argocd-stack-build: guard-ENV guard-CLOUD guard-STACK ## Setup ArgoCD applications
	@./hack/scripts/argocd-app.sh $(CLOUD) $(ENV) $(STACK) build
