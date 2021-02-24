+++
title = "Authentication and Authorization"
description = "Authentication and authorization support for Portefaix in AWS"
weight = 90
+++

This section shows the how to setup Portefaix with authentication and authorization support in Amazon Webservices (AWS)

## Configure AWS

```shell
❯ . ./portefaix.sh aws
[ Portefaix ]
Setup credentials
Done
```

## Configure kubectl

```shell
❯ make kubernetes-credentials CLOUD=aws ENV=staging
```

```shell
❯ kubectl get nodes
NAME                                        STATUS   ROLES    AGE    VERSION
ip-10-0-31-216.eu-west-3.compute.internal   Ready    <none>   101m   v1.18.9-eks-d1db3c
ip-10-0-40-203.eu-west-3.compute.internal   Ready    <none>   101m   v1.18.9-eks-d1db3c
```
