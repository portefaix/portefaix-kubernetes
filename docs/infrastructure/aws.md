# Amazon AWS

!!! info
    Work In Progress

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

![Tfsec AWS](https://github.com/nlamirault/portefaix/workflows/Tfsec%20AWS/badge.svg)

Infrastructure As Code for Portefaix using Amazon AWS is in
`iac/aws` directory

!!! caution "Prerequisites"
    A project created on Amazon AWS

    Edit `iac/aws/aws.staging.mk` or add another file named :
    `iac/aws/aws.<ENVIRONMENT>.mk`

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

#### Cert-Manager

```shell
❯ make terraform-apply SERVICE=iac/aws/cert-manager ENV=staging

Outputs:

role_arn = arn:aws:iam::xxxxxxxxxxxxxxxxx:role/portefaix-staging-eks-cert-manager
```

## Access

Configure kubectl

```shell
❯ make kubernetes-credentials CLOUD=aws ENV=staging
```

```shell
❯ kubectl get nodes
NAME                                        STATUS   ROLES    AGE    VERSION
ip-10-0-31-216.eu-west-3.compute.internal   Ready    <none>   101m   v1.18.9-eks-d1db3c
ip-10-0-40-203.eu-west-3.compute.internal   Ready    <none>   101m   v1.18.9-eks-d1db3c
```

## Inspec

[inspec](http://inspec.io/) is used to check infrastructure.

Check:

```shell
❯ make -f hack/aws.mk inspec-debug
Test infrastructure

 ────────────────────────────── Platform Details ──────────────────────────────

Name:      aws
Families:  cloud, api
Release:   train-aws: v0.1.15, aws-sdk-core: v3.94.0
```

Execute tests:

```shell
❯ make -f hack/aws.mk inspec-test SERVICE=iac/aws/<SERVICE> ENV=staging
```

You could upload JSON results file to [Heimdall Lite](https://heimdall-lite.mitre.org/) to display ressults

### CIS AWS Foundations Benchmark

You could perform tests according to the [CIS AWS Foundations Benchmark](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards-cis.html):

```shell
❯ make -f hack/aws.mk inspec-cis SERVICE=iac/aws/vpc ENV=staging
```

### AWS-VPC

![Inspec](../img/inspec-vpc.png)

| Code | Description|
|---|---|
| `vpc-1` | Check that VPC tags are correctly set |

### AWS-EKS

![Inspec](../img/inspec-eks.png)

| Code | Description|
|---|---|
| `eks-1` | Ensure the AWS EKS Cluster is running a minimal version |
| `eks-2` | Ensure the AWS EKS Cluster control plane has audit logs enabled |
| `eks-3` | Ensure the AWS EKS Cluster is not public |
| `eks-4` | Ensure the AWS EKS Cluster has application secrets encryption enabled |
| `eks-5` | Ensure AWS EKS Cluster Subnets are specific |
| `eks-6` | Ensure AWS EKS Cluster Nodegroups do not allow remote access from all IPs |

## Flux on EKS

```shell
❯ make gitops-bootstrap ENV=staging CLOUD=aws BRANCH=master
```

## AWS-Sops

```shell
❯ make -f hack/aws.mk inspec-test SERVICE=iac/aws/sops ENV=staging
Test infrastructure

Profile: Portefaix sops (portefaix-sops)
Version: 0.1.0
Target:  aws://eu-west-3

  ✔  sops-1: Check that Kms key exist and tags are correctly set
     ✔  KMS Key arn:aws:kms:eu-west-3:447241706233:key/80b36114-3fc2-4401-b5f2-dcd2a4b7e830 is expected to exist
     ✔  KMS Key arn:aws:kms:eu-west-3:447241706233:key/80b36114-3fc2-4401-b5f2-dcd2a4b7e830 is expected to be enabled
     ✔  KMS Key arn:aws:kms:eu-west-3:447241706233:key/80b36114-3fc2-4401-b5f2-dcd2a4b7e830 is expected not to be managed by aws
  ✔  sops-2: Check IAM
     ✔  AWS IAM Role portefaix-staging-eks-sops-eks is expected to exist
     ✔  AWS Iam Policy portefaix-staging-eks-sops is expected to exist

Profile Summary: 2 successful controls, 0 control failures, 0 controls skipped
Test Summary: 5 successful, 0 failures, 0 skipped
```

### AWS-Velero

```shell
❯ make -f hack/aws.mk inspec-test SERVICE=iac/aws/velero ENV=staging
Test infrastructure

Profile: Portefaix VPC (portefaix-vpc)
Version: 0.1.0
Target:  aws://eu-west-3

  ✔  velero-1: Check that S3 bucket exist
     ✔  S3 Bucket portefaix-staging-eks-velero is expected to exist
     ✔  S3 Bucket portefaix-staging-eks-velero is expected not to be public
     ✔  S3 Bucket portefaix-staging-eks-velero is expected to have default encryption enabled
     ✔  S3 Bucket portefaix-staging-eks-velero tags is expected to include {"made-by" => "terraform", "project" => "portefaix", "service" => "velero"}
  ✔  velero-2: Check that Kms key exist and tags are correctly set
     ✔  KMS Key arn:aws:kms:eu-west-3:447241706233:key/80b36114-3fc2-4401-b5f2-dcd2a4b7e830 is expected to exist
  ✔  velero-3: Check IAM
     ✔  AWS IAM Role portefaix-staging-eks-velero is expected to exist
     ✔  AWS Iam Policy portefaix-staging-eks-velero is expected to exist

Profile Summary: 3 successful controls, 0 control failures, 0 controls skipped
Test Summary: 7 successful, 0 failures, 0 skipped
```