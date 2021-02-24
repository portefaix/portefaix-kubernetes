+++
title = "Inspec Portefaix"
description = "Instructions for check Portefaix infrastructure on AWS"
weight = 20
+++

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

## CIS AWS Foundations Benchmark

You could perform tests according to the [CIS AWS Foundations Benchmark](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards-cis.html):

```shell
❯ make -f hack/aws.mk inspec-aws-cis ENV=staging
```

## CIS Kubernetes Benchmark

```shell
❯ make -f hack/aws.mk inspec-aws-kubernetes ENV=staging
```

## AWS-VPC

```shell
❯ make -f hack/aws.mk inspec-test SERVICE=iac/aws/vpc ENV=staging
```

<img src="/docs/images/inspec-aws-vpc.png"
 alt="VPC"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `vpc-1` | Ensure that VPC exist and tags correcly set |
| `vpc-2` | Ensure that VPC have an Internet Gateway |
| `vpc-3` | Check AWS Security Groups does not have undesirable rules |
| `vpc-4` | Ensure that VPC Subnets exists |

## AWS-EKS

```shell
❯ make -f hack/aws.mk inspec-test SERVICE=iac/aws/eks ENV=staging
```

<img src="/docs/images/inspec-aws-eks.png"
 alt="EKS"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `eks-1` | Ensure the AWS EKS Cluster is running a minimal version |
| `eks-2` | Ensure the AWS EKS Cluster control plane has audit logs enabled |
| `eks-3` | Ensure the AWS EKS Cluster is not public |
| `eks-4` | Ensure the AWS EKS Cluster has application secrets encryption enabled |
| `eks-5` | Ensure AWS EKS Cluster Subnets are specific |
| `eks-6` | Ensure AWS EKS Cluster Nodegroups do not allow remote access from all IPs

## AWS-Sops

```shell
❯ make -f hack/aws.mk inspec-test SERVICE=iac/aws/sops ENV=staging
```

<img src="/docs/images/inspec-aws-sops.png"
 alt="Sops"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `sops-1` | Ensure that Kms key exist |
| `sops-1` | Ensure IAM roles and policies exists |

## AWS-Observability

```shell
❯ make -f hack/aws.mk inspec-test SERVICE=iac/aws/observability ENV=staging
```

<img src="/docs/images/inspec-aws-observability.png"
 alt="Observability"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `grafana-1` | Ensure IAM roles and policies exists |
| `prometheus-1` | Ensure IAM roles and policies exists |
| `thanos-1` | Ensure that S3 bucket exist and tags correcly set |
| `thanos-2` | Ensure that S3 log bucket exist and tags correcly set |
| `thanos-3` | Ensure that Kms key exist |
| `thanos-4` | Ensure IAM roles and policies exists |
| `loki-1` | Ensure that S3 bucket exist and tags correcly set |
| `loki-2` | Ensure that S3 log bucket exist and tags correcly set |
| `loki-3` | Ensure that Kms key exist |
| `loki-4` | Ensure IAM roles and policies exists |
| `tempo-1` | Ensure that S3 bucket exist and tags correcly set |
| `tempo-2` | Ensure that S3 log bucket exist and tags correcly set |
| `tempo-3` | Ensure that Kms key exist |
| `tempo-4` | Ensure IAM roles and policies exists |

## AWS-Velero

```shell
❯ make -f hack/aws.mk inspec-test SERVICE=iac/aws/velero ENV=staging
```

<img src="/docs/images/inspec-aws-velero.png"
 alt="Velero"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `velero-1` | Ensure that S3 bucket exist and tags correcly set |
| `velero-2` | Ensure that S3 log bucket exist and tags correcly set |
| `velero-3` | Ensure that Kms key exist |
| `velero-4` | Ensure IAM roles and policies exists |

## AWS-Vector

```shell
❯ make -f hack/aws.mk inspec-test SERVICE=iac/aws/vector ENV=staging
```

<img src="/docs/images/inspec-aws-vector.png"
 alt="Vector"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `vector-1` | Ensure that S3 bucket exist and tags correcly set |
| `vector-2` | Ensure that S3 log bucket exist and tags correcly set |
| `vector-3` | Ensure that Kms key exist |
| `vector-4` | Ensure IAM roles and policies exists |
