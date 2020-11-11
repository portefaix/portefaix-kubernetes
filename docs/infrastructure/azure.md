# Azure

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
