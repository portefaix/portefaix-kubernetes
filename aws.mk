# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

include commons.mk
include aws.*.mk

AWS_PROJECT = $(AWS_PROJECT_$(ENV))

AWS_REGION = $(AWS_REGION_$(ENV))

AWS_CLUSTER = $(AWS_CLUSTER_$(ENV))

RUBY_PATH=PATH=${HOME}/.gem/ruby/2.7.0/bin/:${PATH}


# ====================================
# A W S
# ====================================

##@ AWS

.PHONY: aws-bucket-create
aws-bucket-create: guard-ENV ## Create bucket for bootstrap
	@echo -e "$(OK_COLOR)[$(APP)] Create bucket for bootstrap$(NO_COLOR)"
	@aws s3api create-bucket --bucket $(AWS_PROJECT)-tfstates \
    	--region $(AWS_REGION) \
    	--create-bucket-configuration \
    	LocationConstraint=$(AWS_REGION)

.PHONY: aws-dynamodb-create-table
aws-dynamodb-create-table: guard-ENV ## Create DynamoDB table
	@echo -e "$(OK_COLOR)[$(APP)] Create DynamoDB table$(NO_COLOR)"
	@aws dynamodb create-table \
		--region $(AWS_REGION) \
		--table-name $(AWS_PROJECT)-tfstate-lock \
		--attribute-definitions AttributeName=LockID,AttributeType=S \
		--key-schema AttributeName=LockID,KeyType=HASH \
		--provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

.PHONY: aws-kube-credentials
aws-kube-credentials: guard-ENV ## Generate credentials
	@aws eks update-kubeconfig --name $(AWS_CLUSTER) --region $(AWS_REGION)


# ====================================
# I N S P E C
# ====================================

##@ Inspec

.PHONY: inspec-init
inspec-init: ## Install requirements
	@echo -e "$(OK_COLOR)Install requirements$(NO_COLOR)"
	@PATH=${HOME}/.gem/ruby/2.7.0/bin/:${PATH} bundle install

.PHONY: inspec-test
inspec-test: guard-SERVICE guard-ENV ## Test inspec
	@echo -e "$(OK_COLOR)Test infrastructure$(NO_COLOR)"
	@cd $(SERVICE)/inspec \
		&& $(RUBY_PATH) inspec exec . -t aws:// --input-file=attributes/$(ENV).yml
