+++
title = "Inspec Portefaix"
description = "Instructions for check Portefaix infrastructure on Microsoft Azure"
weight = 20
+++

## Inspec

[inspec](http://inspec.io/) is used to check infrastructure.

Check:

```shell
❯ make -f hack/azure.mk inspec-debug
Test infrastructure

 ────────────────────────────── Platform Details ──────────────────────────────

Name:      azure
Families:  cloud, api
Release:   azure_mgmt_resources-v0.17.8
```

Execute tests:

```shell
❯ make -f hack/azure.mk inspec-test SERVICE=iac/azure/<SERVICE> ENV=dev
```

You could upload JSON results file to [Heimdall Lite](https://heimdall-lite.mitre.org/) to display ressults

### Microsoft Azure CIS Foundations

You could perform tests accoring the [CIS Microsoft Azure Foundations Security Benchmark](https://azure.microsoft.com/fr-fr/resources/cis-microsoft-azure-foundations-security-benchmark/):

```shell
❯ make -f hack/azure.mk inspec-cis ENV=dev
```

### Inspec-AKS

<img src="/docs/images/inspec-azure-aks.png"
 alt="AKS"
 class="mt-3 mb-3 border border-info rounded">

| Code | Description|
|---|---|
| `resourcegroup-1` | Check that resource group exists |
| `aks-1` | Ensure logging to Azure Monitor is configured |
| `aks-2` | Ensure RBAC is enabled |
| `aks-3` | Ensure API Server Authorized IP Ranges are configured |
