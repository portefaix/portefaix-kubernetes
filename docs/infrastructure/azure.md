# Azure

## Setup

Configure Portefaix environment file (`${HOME}/.config/portefaix/portefaix.sh`) :

```shell
# Azure
export AZURE_SUBSCRIPTION_ID="xxxxxxxxxxxxxxxxx"

export TF_VAR_subscription_id="${AZURE_SUBSCRIPTION_ID}"
export TF_VAR_authorized_ip_ranges='["xx.xx.xx.xx/32"]'
```

## Infrastructure

Infrastructure As Code for Portefaix using Azure is in
`iac/azure` directory

!!! caution "Prerequisites"
    A project created on Azure

    Edit `iac/azure/azure.dev.mk` or add another file named :
    **iac/azure/azure.<ENVIRONMENT>.mk**

!!! info
    Work In Progress

## Storage for Terraform

Create a [Storage Account](https://portal.azure.com/#create/Microsoft.StorageAccount) :

```shell
❯ make -f azure.mk azure-storage-account ENV=dev
XXXXXXXXXXX
```

Create storage container for Terraform states:

```shell
❯ make -f azure.mk azure-storage-container ENV=dev KEY="xxxxxxxxxxxxxxxxx"
```

Create a KeyVault :

```shell
❯ make -f azure.mk azure-keyvault-create ENV=dev
```

## Virtual Network

```shell
❯ make terraform-apply SERVICE=iac/azure/vnet ENV=dev
```

## NAT Gateway

Public IP addresses :

```shell
❯ make terraform-apply SERVICE=iac/azure/public-ips/nat-gateway ENV=dev
```

NAT Gateway service:

```shell
❯ make terraform-apply SERVICE=iac/azure/net-gateway ENV=dev
```

## AKS

```shell
❯ make terraform-apply SERVICE=iac/azure/aks ENV=dev
```

### Kubernetes components

#### Observability

```shell
❯ make terraform-apply SERVICE=iac/gcp/observability ENV=dev
```

#### External DNS

```shell
❯ make terraform-apply SERVICE=iac/gcp/external-dns ENV=dev
```

#### Velero

```shell
❯ make terraform-apply SERVICE=iac/gcp/velero ENV=dev
```

## Access

Configure kubectl

```shell
❯ make -f azure.mk azure-kube-credentials ENV=dev
```

```shell
❯ kubectl get nodes
NAME                           STATUS   ROLES   AGE     VERSION
aks-core-19506595-vmss000000   Ready    agent   4m10s   v1.18.8
aks-core-19506595-vmss000001   Ready    agent   4m12s   v1.18.8
```


## Inspec

[inspec](http://inspec.io/) is used to check infrastructure.

Create Azure Service Principal for Inspec :

```shell
❯ make -f azure.mk azure-inspec-sp ENV=dev
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

```shell
❯ make -f azure.mk inspec-test SERVICE=iac/azure/aks ENV=dev
```

![Inspec](../img/inspec-aks.png)


| Code | Description|
|---|---|
| `resourcegroup-1` | Check that resource group exists |
| `aks-1` | Ensure logging to Azure Monitor is configured |
| `aks-2` | Ensure RBAC is enabled |
| `aks-3` | Ensure API Server Authorized IP Ranges are configured |
