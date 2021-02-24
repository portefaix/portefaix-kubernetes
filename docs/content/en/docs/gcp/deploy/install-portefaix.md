+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix infrastructure on GCP"
weight = 10
+++

<a id="gcloud"/></a>

## Setup

Authenticate on the Google Cloud Platform:

```shell
❯ gcloud auth application-default login
```

Enable APIs:

```shell
❯ make -f hack/gcp.mk gcp-enable-apis ENV=prod
```

Create a bucket for the Terraform tfstates:

```shell
❯ make -f hack/gcp.mk gcp-bucket ENV=prod
```

Configure Portefaix environment file `${HOME}/.config/portefaix/portefaix.sh`:

```shell
# GCP
export TF_VAR_master_authorized_networks='[{"cidr_block": "x.x.x.x/32", "display_name": "Home"}]'
```

And load environment :

```shell
❯ . ./portefaix.sh gcp
```

<a id="terraform"></a>

## Terraform

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

#### Sops

```shell
❯ make terraform-apply SERVICE=iac/gcp/sops ENV=prod

Outputs:

email = xxxxxxxxxxxx-sops@xxxxxxxxxxxx.iam.gserviceaccount.com
key = projects/xxxxxxxxxxxx/locations/europe-west1/keyRings/xxxxxxxxxxxx-sops/cryptoKeys/xxxxxxxxxxxx-sops
```

#### Observability

```shell
❯ make terraform-apply SERVICE=iac/gcp/observability ENV=prod

Outputs:

loki_service_account = xxxxxxxxxx-loki@xxxxxxxxxx.iam.gserviceaccount.com
prometheus_service_account = xxxxxxxxxx-loki@xxxxxxxxxx.iam.gserviceaccount.com
tempo_service_account = xxxxxxxxxx-tempo@xxxxxxxxxx.iam.gserviceaccount.com
thanos_service_account = xxxxxxxxxx-thanos@xxxxxxxxxx.iam.gserviceaccount.com
```

#### Cert Manager

```shell
❯ make terraform-apply SERVICE=iac/gcp/cert-manager ENV=prod

Outputs:

cert_manager_service_account = xxxxxxxxxxx-cert-manager@xxxxxxxxxxx.iam.gserviceaccount.com
```

#### External DNS

```shell
❯ make terraform-apply SERVICE=iac/gcp/external-dns ENV=prod

Outputs:

external_dns_service_account = xxxxxxxxxxx-external-dns@xxxxxxxxxxx.iam.gserviceaccount.com
```

#### Velero

```shell
❯ make terraform-apply SERVICE=iac/gcp/velero ENV=prod

Outputs:

velero_service_account = xxxxxxxxxxx-velero@xxxxxxxxxxx.iam.gserviceaccount.com
```

#### Vector

```shell
❯ make terraform-apply SERVICE=iac/gcp/vector ENV=prod

Outputs:

vector_service_account = xxxxxxxxxxx-vector@xxxxxxxxxxx.iam.gserviceaccount.com
```
