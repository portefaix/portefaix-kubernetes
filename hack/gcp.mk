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

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

include $(MKFILE_DIR)/commons.mk
include $(MKFILE_DIR)/gcp.*.mk

GCP_PROJECT = $(GCP_PROJECT_$(ENV))
GCP_CURRENT_PROJECT = $(shell gcloud info --format='value(config.project)')

GCP_CLUSTER = $(GCP_CLUSTER_$(ENV))
GCP_REGION = $(GCP_REGION_$(ENV))

TF_SA=terraform
TF_SA_EMAIL=$(TF_SA)@$(GCP_PROJECT).iam.gserviceaccount.com

BUNDLE_PATH=$(DIR)/vendor/bundle/ruby/2.7.0/bin


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
	gcloud services enable secretmanager.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable cloudresourcemanager.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable dns.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable cloudkms.googleapis.com --project $(GCP_PROJECT)

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
	# @gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
	# 	--member serviceAccount:$(TF_SA_EMAIL) --role="roles/iam.serviceAccountUser"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/iam.serviceAccountKeyAdmin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/container.clusterAdmin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/container.admin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/secretmanager.admin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/cloudkms.admin"
	@gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--member serviceAccount:$(TF_SA_EMAIL) --role="roles/dns.admin"

.PHONY: gcp-terraform-key
gcp-terraform-key: guard-ENV ## Create a JSON key for the Terraform service account (ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Create key for Terraform service account$(NO_COLOR)"
	@gcloud iam service-accounts keys create ./$(GCP_PROJECT)-tf.json \
		--project $(GCP_PROJECT) \
		--iam-account $(TF_SA_EMAIL)
	@mkdir -p $(CONFIG_HOME)/$(APP) && \
		mv ./$(GCP_PROJECT)-tf.json $(CONFIG_HOME)/$(APP)
	cat $(CONFIG_HOME)/$(APP)/$(GCP_PROJECT)-tf.json | base64 -w0 | gcloud beta secrets create kubernetes-sa-key-b64 \
		--labels=made-by=gcloud,service=kubernetes,env=$(ENV) \
    	--replication-policy="automatic" \
		--data-file=- \
		--project $(GCP_PROJECT)

.PHONY: gcp-bucket
gcp-bucket: guard-ENV ## Setup the bucket for Terraform states
	@echo -e "$(INFO_COLOR)Create the service account into $(GCP_PROJECT) $(NO_COLOR)"
	gsutil mb -p $(GCP_PROJECT) -c "STANDARD" -l "europe-west1" -b on gs://$(GCP_PROJECT)-tfstates

.PHONY: gcp-kube-credentials
gcp-kube-credentials: guard-ENV ## Generate credentials
	gcloud container clusters get-credentials $(GCP_PROJECT)-cluster-gke --region $(GCP_REGION) --project $(GCP_PROJECT)


# ====================================
# I N S P E C
# ====================================

##@ Inspec

.PHONY: inspec-debug
inspec-debug: ## Test inspec
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@bundle exec inspec detect -t gcp://

.PHONY: inspec-test
inspec-test: guard-SERVICE guard-ENV ## Test inspec
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@bundle exec inspec exec $(SERVICE)/inspec \
		-t gcp:// --input-file=$(SERVICE)/inspec/attributes/$(ENV).yml \
		--reporter cli json:$(GCP_PROJECT)_scan.json

.PHONY: inspec-cis
inspec-cis: guard-ENV ## Test inspec
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@bundle exec inspec exec \
		https://github.com/GoogleCloudPlatform/inspec-gcp-cis-benchmark.git \
		-t gcp:// --input gcp_project_id=$(GCP_PROJECT)  \
		--reporter cli json:$(GCP_PROJECT)_scan.json