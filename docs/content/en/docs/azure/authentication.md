+++
title = "Access Control for Azure Deployment"
description = "Restrict access of your deployment to specified IP addresses"
weight = 100

+++

This section shows the how to setup Portefaix with authentication and authorization support in Microsoft Azure (AZURE)

## Configure Azure

```shell
❯ . ./portefaix.sh azure
[ Portefaix ]
Setup credentials
Done
```

## Configure kubectl

```shell
❯ make -f hack/azure.mk azure-kube-credentials ENV=dev
```

```shell
❯ kubectl get nodes
NAME                           STATUS   ROLES   AGE   VERSION
aks-core-19506595-vmss000000   Ready    agent   8h    v1.18.10
```
