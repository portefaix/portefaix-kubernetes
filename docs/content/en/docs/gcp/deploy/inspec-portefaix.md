+++
title = "Inspec Portefaix"
description = "Instructions for check Portefaix infrastructure on GCP"
weight = 20
+++

[inspec](http://inspec.io/) is used to check infrastructure:

```shell
❯ make -f hack/gcp.mk inspec-debug
Test infrastructure

 ────────────────────────────── Platform Details ──────────────────────────────

Name:      gcp
Families:  cloud, api
Release:   google-api-client-v0.34.1
```

Execute tests:

```shell
❯ make -f hack/gcp.mk inspec-test SERVICE=iac/gcp/<SERVICE> ENV=prod
```

You could upload JSON results file to [Heimdall Lite](https://heimdall-lite.mitre.org/) to display ressults

## CIS Kubernetes Benchmark

```shell
❯ make -f hack/gcp.mk inspec-gcp-kubernetes ENV=prod
```

## GCP CIS

You could perform tests accoring the [GCP CIS](https://opensource.googleblog.com/2020/08/assess-security-of-cloud-deployments.html):

```shell
❯ make -f hack/gcp.mk inspec-cis ENV=prod
```

## GCP-VPC

```shell
❯ make -f hack/gcp.mk inspec-test SERVICE=iac/gcp/vpc ENV=prod
```

<img src="/docs/images/inspec-gcp-vpc.png"
 alt="VPC"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `vpc-1` | Ensure default network is deleted |
| `vpc-2` | Ensure network is correctly configure |

## GCP-GKE

```shell
❯ make -f gcp.mk inspec-test SERVICE=iac/gcp/gke ENV=prod
```

<img src="/docs/images/inspec-gcp-gke.png"
 alt="GKE"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `gke-1` | Stackdriver Logging and Monitoring is configured |
| `gke-2` | Basic Authentication is disabled |
| `gke-3` | Ensure GKE Nodes are not public |
| `gke-4` | Ensure the GKE Control Plane is not public |
| `gke-5` | Ensure the Network Policy managed addon is enabled |
| `gke-6` | Ensure OAuth Access Scopes and dedicated Service Accounts for node pools |
| `gke-7` | Ensure GKE Node Pools should use the COS or COS_CONTAINERD Operating System |
| `gke-8` | GKE Workload Identity should be enabled on all node pools |
| `gke-9` | GKE Shielded Nodes should be enabled on all NodePools |
| `gke-10` | Ensure instances have labels |
| `gke-11` | Ensure instances have tags |

## GCP-Sops

```shell
❯ make -f hack/gcp.mk inspec-test SERVICE=iac/gcp/sops ENV=prod
```

<img src="/docs/images/inspec-gcp-sops.png"
 alt="Sops"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `sops-1` | Ensure service account and IAM binding exists |
| `sops-2` | Ensure that Kms key exist |

## GCP-Observability

```shell
❯ make -f hack/gcp.mk inspec-test SERVICE=iac/gcp/observability ENV=prod
```

<img src="/docs/images/inspec-gcp-observability.png"
 alt="Observability"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `grafana-1` | Ensure service account and IAM binding exists |
| `prometheus-1` | Ensure service account and IAM binding exists |
| `thanos-1` | Ensure service account and IAM binding exists |
| `thanos-2` | Ensure that bucket exists and labels correcly set |
| `thanos-3` | Ensure that Kms key exist |
| `loki-1` | Ensure service account and IAM binding exists |
| `loki-2` | Ensure that bucket exists and labels correcly set |
| `loki-3` | Ensure that Kms key exist |
| `tempo-1` | Ensure service account and IAM binding exists |
| `tempo-2` | Ensure that bucket exists and labels correcly set |
| `tempo-3` | Ensure that Kms key exist |

## GCP-Velero

```shell
❯ make -f hack/gcp.mk inspec-test SERVICE=iac/gcp/velero ENV=prod
```

<img src="/docs/images/inspec-gcp-velero.png"
 alt="Velero"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `velero-1` | Ensure service account and IAM binding exists |
| `velero-2` | Ensure that bucket exists and labels correcly set |
| `velero-3` | Ensure that Kms key exist |

## GCP-Vector

```shell
❯ make -f hack/gcp.mk inspec-test SERVICE=iac/gcp/vector ENV=prod
```

<img src="/docs/images/inspec-gcp-vector.png"
 alt="Vector"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `vector-1` | Ensure service account and IAM binding exists |
| `vector-2` | Ensure that bucket exists and labels correcly set |
| `vector-3` | Ensure that Kms key exist |

## GCP-External-DNS

```shell
❯ make -f hack/gcp.mk inspec-test SERVICE=iac/gcp/external-dns ENV=prod
```

<img src="/docs/images/inspec-gcp-external-dns.png"
 alt="External-DNS"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `external_dns-1` | Ensure service account and IAM binding exists |
