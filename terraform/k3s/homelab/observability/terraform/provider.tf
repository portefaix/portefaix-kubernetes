# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

provider "aws" {
  alias = "cloudflare_r2"
  # access_key = var.cloudflare_r2_access_key_id
  # secret_key = var.cloudflare_r2_secret_access_key
  # https://developers.cloudflare.com/r2/platform/s3-compatibility/api/#bucket-region
  region = "auto"
  # fix error validating provider credentials: error calling sts:GetCallerIdentity
  # … lookup sts.auto.amazonaws.com on …: no such host
  skip_credentials_validation = true
  # fix Error: Invalid AWS Region: auto
  skip_region_validation = true
  # fix error retrieving account details: AWS account ID not previously found
  # and failed retrieving via all available methods.
  # caused by iam:ListRoles to iam.amazonaws.com
  # and sts:GetCallerIdentity to sts.auto.amazonaws.com
  skip_requesting_account_id = true
  # skip loading instance profile credentials from 169.254.169.254
  skip_metadata_api_check = true
  # skip ec2/DescribeAccountAttributes to ec2.auto.amazonaws.com
  skip_get_ec2_platforms = true
  endpoints {
    # https://developers.cloudflare.com/r2/platform/s3-compatibility/api/
    s3 = format("https://%s.r2.cloudflarestorage.com", var.cloudflare_account_id)
  }
}

# provider "cloudflare" {
#   api_token = var.cloudflare_api_token
#   # account_id is considered deprecated, but as of 3.20.0
#   # it is still required in the provider
#   # for cloudflare_worker_script
#   account_id = var.account_id
# }
