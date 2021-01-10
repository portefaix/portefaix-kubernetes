# Alicloud

!!! Info
    Work in progress

## Setup

Create and [admin user](https://ram.console.aliyun.com/users), enable API keys and add `AdministratorAccess` [policy](https://ram.console.aliyun.com/permissions)
Then configure Portefaix environment file `${HOME}/.config/portefaix/portefaix.sh`:

```shell
# alicloud
export ALICLOUD_ACCESS_KEY="xxxxxxxx"
export ALICLOUD_SECRET_KEY="xxxxxxxxxx"
export ALICLOUD_REGION="xxxxxxxxxxx"
```

And load environment :

```shell
❯ . ./portefaix.sh alicloud
```

Setup Aliyun profile :

```shell
❯ make -f hack/aliyun.mk aliyun-profile-configure ENV=staging
```

## Storage for Terraform

```shell
❯ make -f hack/aliyun.mk aliyun-bucket-create ENV=staging
```

```shell
❯ make -f hack/aliyun.mk aliyun-tablestore-create ENV=staging
```

## Terraform

Infrastructure As Code for Portefaix using Amazon alicloud is in
`iac/alicloud` directory

!!! caution "Prerequisites"
    A project created on Alibaba Cloud

    Edit `iac/alicloud/alicloud.staging.mk` or add another file named :
    `iac/alicloud/alicloud.<ENVIRONMENT>.mk`

### VPC / NAT Gateway

Create the VPC

```shell
❯ make terraform-apply SERVICE=iac/alicloud/vpc ENV=staging
```

Create the NAT Gateway :

```shell
❯ make terraform-apply SERVICE=iac/alicloud/nat-gateway ENV=staging
```

Create an Elastic IP for the NAT Gateway:

```shell
❯ make terraform-apply SERVICE=iac/alicloud/elastic-ips/nat-gateway ENV=staging
```

### ACK

```shell
❯ make terraform-apply SERVICE=iac/alicloud/ack ENV=staging
```

## Access

Configure kubectl

```shell
❯ make -f hack/alicloud.mk aliyun-kube-credentials ENV=staging
```

```shell
❯ KUBECONFIG=config-portefaix-staging kubectl get nodes
NAME                      STATUS   ROLES    AGE   VERSION
eu-central-1.10.0.1.67    Ready    <none>   16h   v1.18.8-aliyun.1
eu-central-1.10.0.2.235   Ready    <none>   16h   v1.18.8-aliyun.1
```
