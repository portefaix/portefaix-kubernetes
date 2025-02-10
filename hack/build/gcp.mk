# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

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
