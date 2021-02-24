+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix on AWS"
weight = 10
+++

<a id="aws"></a>

## Setup

Create an [admin user](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html).
Then [API Keys](https://console.aws.amazon.com/iam/home?#/security_credentials),
and configure Portefaix environment file `${HOME}/.config/portefaix/portefaix.sh`:

```shell
# AWS
export AWS_ACCESS_KEY_ID="....."
export AWS_SECRET_ACCESS_KEY="....."
export AWS_DEFAULT_REGION="..."
export AWS_REGION="...."
```

And load environment :

```shell
❯ . ./portefaix.sh aws
```

## Storage for Terraform

Create a S3 bucket for Terraform states:

```shell
❯ make -f hack/aws.mk aws-s3-bucket ENV=staging
```

Create a DynamoDB table :

```shell
❯ make -f hack/aws.mk aws-dynamodb-create-table ENV=staging
```

## Terraform

### VPC / Internet Gateway

Create an Elastic IP for Internet Gateway:

```shell
❯ make terraform-apply SERVICE=iac/aws/elastic_ips/internet-gateway ENV=staging
```

Create the VPC and Internet Gateway :

```shell
❯ make terraform-apply SERVICE=iac/aws/vpc ENV=staging
```

### EKS

```shell
❯ make terraform-apply SERVICE=iac/aws/eks ENV=staging
```

### Kubernetes components

#### Sops

```shell
❯ make terraform-apply SERVICE=iac/aws/sops ENV=staging

Outputs:
kms_arn = arn:aws:kms:eu-west-3:447241706233:key/cf77f24a-00db-4d6a-8b4b-a8dec3976ff2
role_arn_eks = arn:aws:iam::447241706233:role/portefaix-staging-eks-sops-eks
role_arn_users = arn:aws:iam::447241706233:role/portefaix-staging-eks-sops-users
```

#### Observability

```shell
❯ make terraform-apply SERVICE=iac/aws/observability ENV=staging

Outputs:

loki_role_arn = arn:aws:iam::xxxxxxxxxxxxx:role/portefaix-staging-eks-loki
prometheus_role_arn = arn:aws:iam::xxxxxxxxxxxxx:role/portefaix-staging-eks-loki
tempo_role_arn = arn:aws:iam::xxxxxxxxxxxxx:role/portefaix-staging-eks-tempo
thanos_role_arn = arn:aws:iam::xxxxxxxxxxxxx:role/portefaix-staging-eks-thanos
```

#### External DNS

```shell
❯ make terraform-apply SERVICE=iac/aws/external-dns ENV=staging

Outputs:

role_arn = arn:aws:iam::xxxxxxxxxxx:role/portefaix-staging-eks-external-dns
```

#### Velero

```shell
❯ make terraform-apply SERVICE=iac/aws/velero ENV=staging

Outputs:

role_arn = arn:aws:iam::xxxxxxxxxxxxxxxxx:role/portefaix-staging-eks-velero
```

#### Vector

```shell
❯ make terraform-apply SERVICE=iac/aws/vector ENV=staging

Outputs:

role_arn = arn:aws:iam::xxxxxxxxxxxxxxxxx:role/portefaix-staging-eks-vector
```

#### Cert-Manager

```shell
❯ make terraform-apply SERVICE=iac/aws/cert-manager ENV=staging

Outputs:

role_arn = arn:aws:iam::xxxxxxxxxxxxxxxxx:role/portefaix-staging-eks-cert-manager
```
