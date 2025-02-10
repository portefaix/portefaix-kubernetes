# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

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
