# Google Cloud Platform

## Infrastructure

Infrastructure As Code for Portefaix using Google Cloud Platform is in
`iac/gcp` directory

!!! caution "Prerequisites"
    A project created on Google Cloud Platform.

    Edit `iac/gcp/gcp.prod.mk` or add another file named :
    **iac/gcp/gcp.<ENVIRONMENT>.mk**

| Applications | Versions | Description|
|---|:--:|---|
| Terraform | `v0.13.5` | Usage of [tfenv](https://github.com/tfutils/tfenv) is recommanded |
| GKE | `v1.17.X` | Use Rapid Channel |

### VPC

```shell
❯ make terraform-apply SERVICE=vpc ENV=prod
```

### Observability

```shell
❯ make terraform-apply SERVICE=observability ENV=prod
```

### Velero

```shell
❯ make terraform-apply SERVICE=velero ENV=prod
```

### GKE

```shell
❯ make terraform-apply SERVICE=gke ENV=prod
```

## Access

Configure kubectl

```shell
❯ make gcloud-kube-credentials ENV=prod
```

```shell
❯ kubectl get nodes
NAME                                                  STATUS   ROLES    AGE     VERSION
gke-portefaix-lab-prod-cluster-g-core-5d5d62be-tf15   Ready    <none>   7h37m   v1.18.9-gke.2501
```

