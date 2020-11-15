# Amazon AWS

!!! info
    Work In Progress

## Setup

Create [API Keys](https://console.aws.amazon.com/iam/home?#/security_credentials),
and configure Portefaix environment file `${HOME}/.config/portefaix/portefaix.sh`:

```shell
# AWS
export AWS_DEFAULT_REGION="..."
export AWS_ACCESS_KEY_ID="....."
export AWS_SECRET_ACCESS_KEY="....."
```

And load environment :

```shell
❯ . ./portefaix.sh
```

## Storage for Terraform

Create a S3 bucket for Terraform states:

```shell
❯ make -f aws.mk aws-s3-bucket ENV=staging
```

Create a DynamoDB table :

```shell
❯ make -f aws.mk aws-dynamodb-create-table ENV=staging
```

## Terraform

Infrastructure As Code for Portefaix using Amazon AWS is in
`iac/aws` directory

!!! caution "Prerequisites"
    A project created on Amazon AWS

    Edit `iac/aws/aws.staging.mk` or add another file named :
    `iac/aws/aws.<ENVIRONMENT>.mk`

### VPC

Create the VPC and Internet NAT Gateway :

```shell
❯ make terraform-apply SERVICE=iac/aws/vpc ENV=staging
```

### EKS

```shell
❯ make terraform-apply SERVICE=iac/aws/eks ENV=staging
```

### Kubernetes components

#### Observability

```shell
❯ make terraform-apply SERVICE=iac/aws/observability ENV=dev
```

#### External DNS

```shell
❯ make terraform-apply SERVICE=iac/aws/external-dns ENV=dev

Outputs:

role_arn = arn:aws:iam::xxxxxxxxxxx:role/external-dns-k8s
```

#### Velero

```shell
❯ make terraform-apply SERVICE=iac/aws/velero ENV=dev

Outputs:

role_arn = arn:aws:iam::xxxxxxxxxxxxxxxxx:role/velero-k8s
```

## Access

Configure kubectl

```shell
❯ make -f aws.mk aws-kube-credentials ENV=staging
```

```shell
❯ kubectl get nodes
NAME                                        STATUS   ROLES    AGE    VERSION
ip-10-0-31-216.eu-west-3.compute.internal   Ready    <none>   101m   v1.18.8-eks-7c9bda
ip-10-0-40-203.eu-west-3.compute.internal   Ready    <none>   101m   v1.18.8-eks-7c9bda
```

## Inspec

[inspec](http://inspec.io/) is used to check infrastructure.

Check:

```shell
❯ make -f aws.mk inspec-debug
Test infrastructure

 ────────────────────────────── Platform Details ──────────────────────────────

Name:      aws
Families:  cloud, api
Release:   train-aws: v0.1.15, aws-sdk-core: v3.94.0
```

Execute tests:

```shell
❯ make -f aws.mk inspec-test SERVICE=iac/aws/<SERVICE> ENV=staging
```

You could upload JSON results file to [Heimdall Lite](https://heimdall-lite.mitre.org/) to display ressults

### CIS AWS Foundations Benchmark

You could perform tests according to the [CIS AWS Foundations Benchmark](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards-cis.html):

```shell
❯ make -f aws.mk inspec-cis SERVICE=iac/aws/vpc ENV=staging
```

### AWS-VPC

![Inspec](../img/inspec-vpc.png)

| Code | Description|
|---|---|
| `vpc-1` | Check that VPC exists |

### AWS-EKS

![Inspec](../img/inspec-eks.png)

| Code | Description|
|---|---|
| `eks-1` | ............ |