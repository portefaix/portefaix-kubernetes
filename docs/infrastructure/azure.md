# Azure

!!! info
    Work In Progress

## Setup

Configure Portefaix environment file `${HOME}/.config/portefaix/portefaix.sh`:

```shell
# Azure
export AZURE_SUBSCRIPTION_ID="xxxxxxxxxxxxxxxxx"

export TF_VAR_subscription_id="${AZURE_SUBSCRIPTION_ID}"
export TF_VAR_authorized_ip_ranges='["xx.xx.xx.xx/32"]'
```

And load environment :

```shell
❯ . ./portefaix.sh
```

## Storage for Terraform

Create a [Storage Account](https://portal.azure.com/#create/Microsoft.StorageAccount) :

```shell
❯ make -f hack/azure.mk azure-storage-account ENV=dev
XXXXXXXXXXX
```

Create storage container for Terraform states:

```shell
❯ make -f hack/azure.mk azure-storage-container ENV=dev KEY="xxxxxxxxxxxxxxxxx"
```

## Terraform

![Tfsec Azure](https://github.com/nlamirault/portefaix/workflows/Tfsec%20Azure/badge.svg)

Infrastructure As Code for Portefaix using Azure is in
`iac/azure` directory

!!! caution "Prerequisites"
    A project created on Azure

    Edit `iac/azure/azure.dev.mk` or add another file named :
    `iac/azure/azure.<ENVIRONMENT>.mk`

### Virtual Network

```shell
❯ make terraform-apply SERVICE=iac/azure/vnet ENV=dev
```

### NAT Gateway

Public IP addresses :

```shell
❯ make terraform-apply SERVICE=iac/azure/public-ips/nat-gateway ENV=dev
```

NAT Gateway service:

```shell
❯ make terraform-apply SERVICE=iac/azure/net-gateway ENV=dev
```

### AKS

```shell
❯ make terraform-apply SERVICE=iac/azure/aks ENV=dev
```

### Kubernetes components

#### Observability

```shell
❯ make terraform-apply SERVICE=iac/azure/observability ENV=dev
```

#### External DNS

```shell
❯ make terraform-apply SERVICE=iac/azure/external-dns ENV=dev
```

#### Velero

```shell
❯ make terraform-apply SERVICE=iac/azure/velero ENV=dev
```

## Access

Configure kubectl

```shell
❯ make kubernetes-credentials CLOUD=azure ENV=dev
```

```shell
❯ kubectl get nodes
NAME                           STATUS   ROLES   AGE     VERSION
aks-core-19506595-vmss000000   Ready    agent   4m10s   v1.18.8
aks-core-19506595-vmss000001   Ready    agent   4m12s   v1.18.8
```

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

Create Azure Service Principal for Inspec :

```shell
❯ make -f hack/azure.mk azure-inspec-sp ENV=dev
Changing "portefaix-dev-inspec" to a valid URI of "http://portefaix-dev-inspec", which is the required format used for service principal names
Creating a role assignment under the scope of "/subscriptions/xxxxxxxxxx"
{
  "appId": "xxxxxxxxxxxx",
  "displayName": "portefaix-dev-inspec",
  "name": "http://portefaix-dev-inspec",
  "password": "xxxxxxxxxxxxxx",
  "tenant": "xxxxxxxxxxxxxxxxxxx"
}
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

### Azure-AKS

![Inspec](../img/inspec-aks.png)

| Code | Description|
|---|---|
| `resourcegroup-1` | Check that resource group exists |
| `aks-1` | Ensure logging to Azure Monitor is configured |
| `aks-2` | Ensure RBAC is enabled |
| `aks-3` | Ensure API Server Authorized IP Ranges are configured |
