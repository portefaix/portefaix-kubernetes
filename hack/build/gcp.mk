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

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/gcp.*.mk

GCP_PROJECT = $(GCP_PROJECT_$(ENV))
GCP_CURRENT_PROJECT = $(shell gcloud info --format='value(config.project)')

GCP_CLUSTER = $(GCP_CLUSTER_$(ENV))
GCP_REGION = $(GCP_REGION_$(ENV))

GCP_BASTION = $(GCP_BASTION_$(ENV))
GCP_BASTION_ZONE= $(GCP_BASTION_ZONE_$(ENV))

GCP_SECRET_LOCATIONS = $(GCP_SECRET_LOCATIONS_$(ENV))

TF_SA=terraform
TF_SA_EMAIL=$(TF_SA)@$(GCP_PROJECT).iam.gserviceaccount.com

# Tags: tags/x.x.x.x
# Branch: heads/x.x.x.x
# INSPEC_PORTEFAIX_GCP_VERSION = heads/master
INSPEC_PORTEFAIX_GCP_VERSION = tags/v0.2.0
INSPEC_PORTEFAIX_GCP = https://github.com/portefaix/portefaix-inspec-gcp/archive/refs/$(INSPEC_PORTEFAIX_GCP_VERSION).zip


##@ Development

.PHONY: check
check: guard-ENV ## Check requirements
	@if [[ "${GCP_PROJECT}" != "${GCP_CURRENT_PROJECT}" ]] ; then \
		echo -e "$(ERROR_COLOR)$(KO)$(NO_COLOR) ${GCP_CURRENT_PROJECT}"; \
	else \
		echo -e "$(OK_COLOR)$(OK)$(NO_COLOR) ${GCP_CURRENT_PROJECT}"; \
	fi


# ====================================
# G C L O U D
# ====================================

##@ GCloud


.PHONY: gcp-project-switch
gcp-project-switch: guard-ENV ## Switch GCP project
	gcloud config set project ${GCP_PROJECT}

.PHONY: gcp-enable-apis
gcp-enable-apis: guard-ENV ## Enable APIs on project
	@echo -e "$(OK_COLOR)[$(APP)] Create service account for Terraform$(NO_COLOR)"
	gcloud services enable iam.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable cloudresourcemanager.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable compute.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable container.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable containerregistry.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable containersecurity.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable artifactregistry.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable secretmanager.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable dns.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable cloudkms.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable iap.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable pubsub.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable iamcredentials.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable sts.googleapis.com --project $(GCP_PROJECT)

.PHONY: gcp-terraform-sa
gcp-terraform-sa: guard-ENV ## Create service account for Terraform (ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Create service account for Terraform$(NO_COLOR)"
	@gcloud iam service-accounts create $(TF_SA) \
		--project $(GCP_PROJECT) --display-name $(TF_SA) \
		--description "Created by GCloud"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
    	--member serviceAccount:$(TF_SA_EMAIL) --role="roles/storage.admin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
    	--member serviceAccount:$(TF_SA_EMAIL) --role="roles/storage.objectAdmin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
    	--member serviceAccount:$(TF_SA_EMAIL) --role="roles/storage.objectViewer"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
    	--member serviceAccount:$(TF_SA_EMAIL) --role="roles/compute.instanceAdmin.v1"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
    	--member serviceAccount:$(TF_SA_EMAIL) --role="roles/compute.securityAdmin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
    	--member serviceAccount:$(TF_SA_EMAIL) --role="roles/compute.networkAdmin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
    	--member serviceAccount:$(TF_SA_EMAIL) --role="roles/resourcemanager.projectIamAdmin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/iam.serviceAccountAdmin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/iam.serviceAccountUser"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/iam.roleAdmin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/iam.serviceAccountKeyAdmin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/container.clusterAdmin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/container.admin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="containersecurity.clusterSummaries.list"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="containersecurity.workloadConfigAudits.list"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/secretmanager.admin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/cloudkms.admin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/cloudkms.cryptoKeyEncrypterDecrypter"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/dns.admin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/iap.admin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/pubsub.admin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/artifactregistry.repoAdmin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/artifactregistry.admin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/iam.workloadIdentityPoolAdmin"

.PHONY: gcp-terraform-key
gcp-terraform-key: guard-ENV ## Create a JSON key for the Terraform service account (ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Create key for Terraform service account$(NO_COLOR)"
	@gcloud iam service-accounts keys create ./$(GCP_PROJECT).json \
		--project $(GCP_PROJECT) \
		--iam-account $(TF_SA_EMAIL)
	@mkdir -p $(CONFIG_HOME)/$(APP) && \
		mv ./$(GCP_PROJECT).json $(CONFIG_HOME)/$(APP)

# cat $(CONFIG_HOME)/$(APP)/$(GCP_PROJECT)-tf.json | base64 -w0 | gcloud beta secrets create kubernetes-sa-key-b64 \
# 	--labels=made-by=gcloud,service=kubernetes,env=$(ENV) \
# 	--replication-policy="automatic" \
# 	--data-file=- \
# 	--project $(GCP_PROJECT)

.PHONY: gcp-bucket
gcp-bucket: guard-ENV ## Setup the bucket for Terraform states
	@echo -e "$(INFO_COLOR)Create the service account into $(GCP_PROJECT) $(NO_COLOR)"
	gsutil mb -p $(GCP_PROJECT) -c "STANDARD" -l "europe-west1" -b on gs://$(GCP_PROJECT)-tfstates

.PHONY: gcp-kube-credentials
gcp-kube-credentials: guard-ENV ## Generate credentials
	gcloud container clusters get-credentials $(GCP_PROJECT)-cluster-gke --region $(GCP_REGION) --project $(GCP_PROJECT)

.PHONY: gcp-ssh-bastion
gcp-ssh-bastion: guard-ENV ## SSH into the bastion through IAP
	@echo -e "$(INFO_COLOR)Connect to the bastion for $(GCP_PROJECT)$(NO_COLOR)"
	gcloud beta compute ssh $(GCP_BASTION) --tunnel-through-iap --project $(GCP_PROJECT) --zone $(GCP_BASTION_ZONE) -- -L8888:127.0.0.1:8888

.PHONY: gcp-secret-version-create
gcp-secret-version-create: guard-ENV guard-VERSION # Generate secret
	@echo -e "$(INFO_COLOR)Create the secret for Portefaix version into $(GCP_PROJECT)$(NO_COLOR)"
	echo $(VERSION) | gcloud beta secrets create portefaix-version \
		--data-file=- --replication-policy=user-managed \
		--locations=$(GCP_SECRET_LOCATIONS) \
		--labels=env=prod --labels=service=secrets --labels=made-by=gcloud \
		--project $(GCP_PROJECT)

.PHONY: gcp-secret-version-update
gcp-secret-version-update: guard-ENV guard-VERSION # Generate secret
	@echo -e "$(INFO_COLOR)Update the secret for Portefaix version into $(GCP_PROJECT)$(NO_COLOR)"
	echo $(VERSION) | gcloud beta secrets versions add portefaix-version \
		--data-file=- --project $(GCP_PROJECT)

# ====================================
# I N S P E C
# ====================================

##@ Inspec

.PHONY: inspec-gcp-debug
inspec-gcp-debug: ## Debug Inspec
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS=1 bundle exec inspec detect -t gcp://

.PHONY: inspec-test
inspec-gcp-test: guard-SERVICE guard-ENV ## Inspec test a service
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS=1 bundle exec inspec exec $(SERVICE)/inspec \
		-t gcp:// --input-file=$(SERVICE)/inspec/attributes/$(ENV).yml \
		--reporter cli json:$(GCP_PROJECT)_$(SERVICE).json html:$(GCP_PROJECT)_$(SERVICE).html

.PHONY: inspec-gcp-cis
inspec-gcp-cis: guard-ENV ## Execute Inspec CIS profile
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS=1 bundle exec inspec exec \
		https://github.com/GoogleCloudPlatform/inspec-gcp-cis-benchmark.git \
		-t gcp:// --input-file=inspec/gcp/attributes/cis-$(ENV).yml \
		--reporter cli json:$(GCP_PROJECT)_csp.json html:$(GCP_PROJECT)_cis.html

.PHONY: inspec-gcp-portefaix
inspec-gcp-portefaix: guard-ENV ## Execute Inspec Portefaix profile
	@echo -e "$(OK_COLOR)Test infrastructure with Portefaix Inspec profile$(NO_COLOR)"
	@GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS=1 bundle exec inspec exec \
		$(INSPEC_PORTEFAIX_GCP) \
		-t gcp:// --input-file=inspec/gcp/attributes/portefaix-$(ENV).yml \
		--reporter cli json:$(GCP_PROJECT)_portefaix.json html:$(GCP_PROJECT)_portefaix.html

.PHONY: inspec-gcp-kubernetes
inspec-gcp-kubernetes: guard-ENV ## Kubernetes CIS
	@echo -e "$(OK_COLOR)CIS Kubernetes benchmark$(NO_COLOR)"
	@bundle exec inspec exec \
		https://github.com/dev-sec/cis-kubernetes-benchmark.git \
		--reporter cli json:$(GCP_PROJECT)_k8s.json html:$(GCP_PROJECT)_k8s.html
