# Google Cloud Platform

## Infrastructure

Infrastructure As Code for Portefaix on Google Cloud Platform is in
`iac/gcp` directory

!!! caution "Prerequisites"
    A project created on Google Cloud Platform.

    Edit `iac/gcp/gcp.prod.mk` or add another file named :
    `iac/gcp/gcp.<ENVIRONMENT>.mk`

| Applications | Versions | Description|
|---|:--:|---|
| Terraform | `v0.13.5` | Usage of [tfenv](https://github.com/tfutils/tfenv) is recommanded |
| GKE | `v1.18.X` | Rapid Channel |

### VPC

```shell
❯ make terraform-apply SERVICE=iac/gcp/vpc ENV=prod
```

### Cloud DNS

```shell
❯ make terraform-apply SERVICE=iac/gcp/dns ENV=prod
```

### Cloud NAT

```shell
❯ make terraform-apply SERVICE=iac/gcp/external-ips/cloud-nat ENV=prod
```

```shell
❯ make terraform-apply SERVICE=iac/gcp/cloud-nat ENV=prod
```

### GKE

```shell
❯ make terraform-apply SERVICE=iac/gcp/gke ENV=prod
```

### Kubernetes components

#### Observability

```shell
❯ make terraform-apply SERVICE=iac/gcp/observability ENV=prod
```

#### External DNS

```shell
❯ make terraform-apply SERVICE=iac/gcp/external-dns ENV=prod
```

#### Velero

```shell
❯ make terraform-apply SERVICE=iac/gcp/velero ENV=prod
```

## Access

Configure kubectl

```shell
❯ make -f gcp.mk gcloud-kube-credentials ENV=prod
```

```shell
❯ kubectl get nodes
NAME                                                  STATUS   ROLES    AGE     VERSION
gke-portefaix-lab-prod-cluster-g-core-5d5d62be-tf15   Ready    <none>   7h37m   v1.18.10-gke.601
```

