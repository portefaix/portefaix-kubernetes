# Scaleway

!!! info
    Work In Progress

## Setup

Configure Portefaix environment file `${HOME}/.config/portefaix/portefaix.sh`:

```shell
function setup_scaleway() {
    export SCW_ACCESS_KEY="xxxxxxxxxx"
    export SCW_SECRET_KEY="xxxxxxxxx"
    export SCW_DEFAULT_PROJECT_ID="xxxxxxxxx"
    export SCW_DEFAULT_ORGANIZATION_ID="${SCW_DEFAULT_PROJECT_ID}"
    export AWS_ACCESS_KEY_ID="${SCW_ACCESS_KEY}"
    export AWS_SECRET_ACCESS_KEY="${SCW_SECRET_KEY}"
    export AWS_DEFAULT_REGION="eu-west-3"
    export AWS_REGION="eu-west-3"
}
```

And load environment :

```shell
❯ . ./portefaix.sh
```

## Terraform

Infrastructure As Code for Portefaix using Azure is in
`iac/scaleway` directory

!!! caution "Prerequisites"
    A project created on Azure

    Edit `iac/scaleway/scaleway.staging.mk` or add another file named :
    `iac/scaleway/scaleway.<ENVIRONMENT>.mk`

### Kapsule

```shell
❯ make terraform-apply SERVICE=iac/scaleway/kapsule ENV=sandbox
```

## Inspec

## Access

Configure kubectl

```shell
❯ make -f scw.mk scw-kube-credentials ENV=staging
```

```shell
❯ kubectl get nodes
NAME                                             STATUS   ROLES    AGE   VERSION
scw-portefaix-staging-kapsule-core-740bfe09e85   Ready    <none>   11h   v1.18.12
scw-portefaix-staging-kapsule-ops-30b80b2cad4a   Ready    <none>   11h   v1.18.12
```

