+++
title = "Authentication and Authorization"
description = "Authentication and authorization support for Portefaix in GCP"
weight = 90
+++

This section shows the how to setup Portefaix with authentication and authorization support in Google Cloud Platform (GCP).

## Configure Gcloud

```shell
❯ . ./portefaix.sh gcp
[ Portefaix ]
Setup credentials
Done
```

## Configure kubectl

```shell
❯ make kubernetes-credentials CLOUD=gcp ENV=prod
```

```shell
❯ kubectl get nodes
NAME                                                  STATUS   ROLES    AGE     VERSION
gke-xxxxxxxxxx-cluster-g-core-5d5d62be-tf15   Ready    <none>   7h37m   v1.18.10-gke.601
```
