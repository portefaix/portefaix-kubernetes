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
include gcp.*.mk

GCP_PROJECT = $(GCP_PROJECT_$(ENV))
GCP_CURRENT_PROJECT = $(shell gcloud info --format='value(config.project)')

# KUBE_CONTEXT = $(KUBE_CONTEXT_$(ENV))
# KUBE_CURRENT_CONTEXT = $(shell kubectl config current-context)

GCP_CLUSTER = $(GCP_CLUSTER_$(ENV))
GCP_REGION = $(GCP_REGION_$(ENV))

KMS_KEYRING = $(KMS_KEYRING_$(ENV))
KMS_KEY = $(KMS_KEY_$(ENV))
KMS_LOCATION = $(KMS_LOCATION_$(ENV))

TF_SA=terraform
TF_SA_EMAIL=$(TF_SA)@$(GCP_PROJECT).iam.gserviceaccount.com

RUBY_PATH=PATH=${HOME}/.gem/ruby/2.7.0/bin/:${PATH}


# HOMEDIR=/home/node
# WORKDIR=${HOMEDIR}/audit

# CHECKK8S="k8s.sh"
# CHECKGKE="gke.sh"

# IMAGENAME=mkit
# IMAGEREPO=darkbitio/$(IMAGENAME)
# IMAGEPATH=$(IMAGEREPO):latest
# COMMAND=docker run --rm -it -p8000:8000 -v "$(PWD)/support/input.yaml":$(WORKDIR)/input.yaml

# GKECOMMAND=$(COMMAND) \
#   -v $(HOME)/.config/gcloud:$(HOMEDIR)/.config/gcloud \
#   -e GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS=true
# GKEINSPECRUN=$(GKECOMMAND) --entrypoint $(WORKDIR)/$(CHECKGKE) $(IMAGEPATH) "$(project_id)" "$(location)" "$(clustername)"


# ====================================
# G C L O U D
# ====================================

##@ GCloud


.PHONY: gcloud-project-switch
gcloud-project-switch: guard-ENV ## Switch GCP project
	gcloud config set project ${GCP_PROJECT}

.PHONY: gcloud-enable-apis
gcloud-enable-apis: guard-ENV ## Enable APIs on project
	@echo -e "$(OK_COLOR)[$(BANNER)] Create service account for Terraform$(NO_COLOR)"
	gcloud services enable iam.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable cloudresourcemanager.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable compute.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable container.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable containerregistry.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable secretmanager.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable cloudresourcemanager.googleapis.com --project $(GCP_PROJECT)
	gcloud services enable dns.googleapis.com --project $(GCP_PROJECT)

.PHONY: gcloud-terraform-sa
gcloud-terraform-sa: guard-ENV ## Create service account for Terraform (ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Create service account for Terraform$(NO_COLOR)"
	# @gcloud iam service-accounts create $(TF_SA) \
	# 	--project $(GCP_PROJECT) --display-name $(TF_SA) \
	# 	--description "Created by GCloud"
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

.PHONY: gcloud-terraform-key
gcloud-terraform-key: guard-ENV ## Create a JSON key for the Terraform service account (ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Create key for Terraform service account$(NO_COLOR)"
	@gcloud iam service-accounts keys create ./$(GCP_PROJECT)-tf.json \
		--project $(GCP_PROJECT) \
		--iam-account $(TF_SA_EMAIL)
	@mkdir -p $(CONFIG_HOME)/$(APP) && \
		mv ./$(GCP_PROJECT)-tf.json $(CONFIG_HOME)/$(APP)
	cat $(CONFIG_HOME)/$(APP)/$(GCP_PROJECT)-tf.json | base64 -w0 | gcloud beta secrets create kubernetes-sa-key-b64 \
		--labels=made-by=gcloud,service=kubernetes,env=$(ENV) \
    	--replication-policy="automatic" \
		--data-file=-

.PHONY: gcloud-bucket
gcloud-bucket: guard-ENV ## Setup the bucket for Terraform states
	@echo -e "$(INFO_COLOR)Create the service account into $(GCP_PROJECT) $(NO_COLOR)"
	gsutil mb -p $(GCP_PROJECT) gs://$(APP)-tfstates/

.PHONY: gcloud-kube-credentials
gcloud-kube-credentials: guard-ENV ## Generate credentials
	gcloud container clusters get-credentials $(GCP_PROJECT)-cluster-gke --region $(GCP_REGION) --project $(GCP_PROJECT)


# ====================================
# I N S P E C
# ====================================

##@ Inspec

.PHONY: inspec-init
inspec-init: ## Install requirements
	@echo -e "$(OK_COLOR)Install requirements$(NO_COLOR)"
	@PATH=${HOME}/.gem/ruby/2.7.0/bin/:${PATH} bundle install

.PHONY: inspec-deps
inspec-deps: ## Initialize a new Inspec service
	@echo -e "$(OK_COLOR)Update Inspec dependencies$(NO_COLOR)"
	wget https://github.com/darkbitio/inspec-profile-gke/archive/0.1.5.zip \
		&& rm -fr iac/gcp/gke/inspec/libraries iac/gcp/gke/inspec/controls \
		&& unzip 0.1.5.zip -d iac/gcp/gke/inspec \
    	&& mv iac/gcp/gke/inspec/inspec-profile-gke-0.1.5/libraries/ iac/gcp/gke/inspec/ \
		&& mv iac/gcp/gke/inspec/inspec-profile-gke-0.1.5/controls/ iac/gcp/gke/inspec/ \
		&& rm -fr iac/gcp/gke/inspec/inspec-profile-gke-0.1.5/ \
		&& rm 0.1.5.zip

.PHONY: inspec-test
inspec-test: guard-SERVICE guard-ENV ## Test inspec
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@cd $(SERVICE)/inspec \
		&& $(RUBY_PATH) inspec exec . -t gcp:// --input-file=attributes/$(ENV).yml

# .PHONY: inspec-checks
# inspec-gke: guard-ENV ## Check GKE
# 	$(GKEINSPECRUN) project_id=$(GCP_PROJECT) location=$(GCP_REGION) clustername=$(GCP_CLUSTER)