#!/usr/bin/env bash

# Copyright 2021 Nicolas Lamirault.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



HOME_IP=$(curl -s http://ifconfig.me)
SLACK_WEBHOOK_NOTIFS="https://hooks.slack.com/services/...."

# CURRENT_DIR="$(dirname "${BASH_SOURCE[0]}")"
# CURRENT_REAL_DIR="$(realpath "${CURRENT_DIR}")"

CURRENT_DIR="$(dirname "$0}")"
CURRENT_REAL_DIR="$(realpath "${CURRENT_DIR}")"

function usage() {
    echo "Usage: $0 <cloud provider>"
}

# Github for Flux
function setup_flux() {
    export GITHUB_USERNAME="xxxx"
    export GITHUB_TOKEN="xxxxxxxxxxxxxxxx"
}

function setup_pagerduty() {
    export PAGERDUTY_TOKEN="xxxxxxxxxxxxxxx"
}

function setup_tailscale() {
    export PORTEFAIX_TAILSCALE_AUTH_KEY="tskey-xxxxxxxxxxxxxxxxx"
}

function setup_terraform_cloud() {
    export TFE_TOKEN="xxxxxxxxxxxxxxx"
    export TF_VAR_github_oauth_token="xxxxxxxxxxxxxxxx"
}

# GCP
function setup_gcp() {
    export GOOGLE_APPLICATION_CREDENTIALS=${CURRENT_REAL_DIR}/portefaix.json
    TF_VAR_credentials=$(< "${GOOGLE_APPLICATION_CREDENTIALS}" tr -d '\n')
    export TF_VAR_credentials
    export TF_VAR_master_authorized_networks="[{\"cidr_block\": \"${HOME_IP}\", \"display_name\": \"Home\"}]"
}

# AWS
function setup_aws() {
    # AWS user
    export AWS_ACCESS_KEY_ID="xxxxxxxxxx"
    export AWS_SECRET_ACCESS_KEY="xxxxxxxx"
    # AWS region
    export AWS_DEFAULT_REGION="xxxxxxx"
    export AWS_REGION="xxxxxxxxxx"
    export TF_VAR_access_key="${AWS_ACCESS_KEY_ID}"
    export TF_VAR_secret_key="${AWS_SECRET_ACCESS_KEY}"
    export TF_VAR_slack_webhook_url="${SLACK_WEBHOOK_NOTIFS}"
}

# Azure
function setup_azure() {
    export ARM_SUBSCRIPTION_ID="xxxxxxxxxxxxxx"
    export ARM_CLIENT_ID="xxxxxxxxxxxxxx"
    export ARM_CLIENT_SECRET="xxxxxxxxxxxxxx"
    export ARM_TENANT_ID="xxxxxxxxxx"
    # For Inspec
    export AZURE_SUBSCRIPTION_ID="xxxxxxxxxxx"
    export AZURE_CLIENT_ID="xxxxxxxxxxx"
    export AZURE_CLIENT_SECRET="xxxxxxxxxxx"
    export AZURE_TENANT_ID="xxxxxxxxxxx"
    # For Terraform Cloud
    export TF_VAR_arm_subscription_id="${ARM_SUBSCRIPTION_ID}"
    export TF_VAR_arm_client_id="${ARM_CLIENT_ID}"
    export TF_VAR_arm_client_secret="${ARM_CLIENT_SECRET}"
    export TF_VAR_arm_tenant_id="${ARM_TENANT_ID}"
    export TF_VAR_authorized_ip_ranges="[\"${HOME_IP}\"]"
}

# Digital Ocean
function setup_digitalocean() {
    export DIGITALOCEAN_TOKEN="xxxxxxxxxxxxxxxxxx"
    export SPACES_ENDPOINT_URL="fra1.digitaloceanspaces.com"
    export SPACES_ACCESS_KEY_ID="xxxxxxxxxxxxxxx"
    export SPACES_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxxx"
    export AWS_ACCESS_KEY_ID="${SPACES_ACCESS_KEY_ID}"
    export AWS_SECRET_ACCESS_KEY="${SPACES_SECRET_ACCESS_KEY}"
    export AWS_DEFAULT_REGION="xxxxxxxxx"
    export AWS_REGION="xxxxxxxxxx"
}

# Scaleway
function setup_scaleway() {
    export SCW_ACCESS_KEY="xxxxxxxxxxxxxxxxx"
    export SCW_SECRET_KEY="xxxxxxxxxxxxxxxxx"
    export SCW_DEFAULT_PROJECT_ID="xxxxxxxxxxxxxx"
    export SCW_DEFAULT_ORGANIZATION_ID="${SCW_DEFAULT_PROJECT_ID}"
    export AWS_ACCESS_KEY_ID="${SCW_ACCESS_KEY}"
    export AWS_SECRET_ACCESS_KEY="${SCW_SECRET_KEY}"
    export AWS_DEFAULT_REGION="xxxxxxx"
    export AWS_REGION="xxxxxx"
}

# AWS
function setup_alicloud() {
    # Alicloud User: Portefaix Admin
    export ALICLOUD_ACCESS_KEY="xxxxxxxxxxxxxxx"
    export ALICLOUD_SECRET_KEY="xxxxxxxxxxxxxxxx"
    export ALICLOUD_REGION="xxxxxxxxx"
}

# Alicloud
function setup_alicloud() {
    # Alicloud User: Portefaix Admin
    export ALICLOUD_ACCESS_KEY="LTAI4G2YvnZLVXbVk6FSF2TA"
    export ALICLOUD_SECRET_KEY="l284l1iLtIpuZbdq1uwyuOQ6lax4Yl"
    export ALICLOUD_REGION="eu-central-1"
    # For Terraform Cloud
    export TF_VAR_access_key="${ALICLOUD_ACCESS_KEY}"
    export TF_VAR_secret_key="${ALICLOUD_SECRET_KEY}"
    export TF_VAR_region="${ALICLOUD_REGION}"
}

# Exoscale
function setup_exoscale() {
    export EXOSCALE_API_KEY="xxxxxxxxx"
    export EXOSCALE_API_SECRET="xxxxxxxxxxxx"
    export AWS_ACCESS_KEY_ID="${EXOSCALE_API_KEY}"
    export AWS_SECRET_ACCESS_KEY="${EXOSCALE_API_SECRET}"
}

# Oracle Cloud
function setup_oci() {
    export TF_VAR_tenancy_ocid="xxxxxxxxx"
    export TF_VAR_user_ocid="xxxxxxxxx"
    # export TF_VAR_compartment_ocid=<compartment_OCID>
    export TF_VAR_fingerprint="xxxxxxxxxxx"
    TF_VAR_private_key="$(cat "${HOME}"/.oci/oci_api_key.pem)"
    export TF_VAR_private_key
    # For Terraform Backend S3
    export AWS_REGION="xxxxxxxxxx"
    export AWS_ACCESS_KEY_ID="xxxxxxxxxxxx"
    export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxxxx"
}

function main() {
    if [ $# -ne 1 ]; then
        usage
    else
        setup_flux
        setup_pagerduty
        setup_terraform_cloud
        case $1 in
            "gcp")
                setup_gcp
                ;;
            "aws")
                setup_aws
                ;;
            "azure")
                setup_azure
                ;;
            "digitalocean")
                setup_digitalocean
                ;;
            "scaleway")
                setup_scaleway
                ;;
            "alicloud")
                setup_alicloud
                ;;
            "exoscale")
                setup_exoscale
                ;;
            "kind")
                ;;
            "k3s")
                setup_tailscale
                ;;
            *)
                echo -e "${KO_COLOR}Invalid cloud provider: $1.${NO_COLOR}"
                usage
                ;;
        esac
    fi
}

main "$1"
