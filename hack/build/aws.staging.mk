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

AWS_PROJECT_staging = portefaix-staging

AWS_ACCOUNT_ID_staging = 845676325565

AWS_REGION_staging = eu-west-1

AWS_CLUSTER_staging = portefaix-staging-eks

KUBE_CONTEXT_staging = arn:aws:eks:eu-west-1:447241706233:cluster/portefaix-staging-eks

# SOPS_PROVIDER_staging = kms
# SOPS_KEY_KMS_staging = arn:aws:kms:eu-west-1:447241706233:key/80b36114-3fc2-4401-b5f2-dcd2a4b7e830
SOPS_PROVIDER_staging = age
SOPS_KEY_staging = age17hu2c0n3vctxy89v4l9r72fnm2vlxkj884yrzrj7rkh8e25n0cjqlnlan3
SOPS_AGE_KEY_FILE_staging = .secrets/aws/staging/age/age.agekey
