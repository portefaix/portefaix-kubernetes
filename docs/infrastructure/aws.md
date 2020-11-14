# Amazon AWS

!!! info
    Work In Progress

## Setup

Create [API Keys](https://console.aws.amazon.com/iam/home?#/security_credentials),
and configure Portefaix environment file `${HOME}/.config/portefaix/portefaix.sh`:

```shell
# AWS
export AWS_ACCESS_KEY_ID="xxxxxxxxxxxxxxxxxxxxx"
export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxxxx"
```

And load environment :

```shell
❯ . ./portefaix.sh
```

## Storage for Terraform

Create a S3 bucket for Terraform states:

```shell
❯ make -f aws.mk aws-s3-bucket ENV=staging
```

Create a DynamoDB table :

```shell
❯ make -f aws.mk aws-dynamodb-create-table ENV=staging
```

## Terraform

Infrastructure As Code for Portefaix using Amazon AWS is in
`iac/aws` directory

!!! caution "Prerequisites"
    A project created on Amazon AWS

    Edit `iac/aws/aws.prod.mk` or add another file named :
    `iac/aws/aws.<ENVIRONMENT>.mk`

### VPC

Create the VPC and Internet NAT Gateway :

```shell
❯ make terraform-apply SERVICE=iac/aws/vpc ENV=staging
```

### EKS

```shell
❯ make terraform-apply SERVICE=iac/aws/eks ENV=staging
```

## Access

Configure kubectl

```shell
❯ make -f aws.mk aws-kube-credentials ENV=staging
```

```shell
❯ kubectl get nodes
NAME                                        STATUS   ROLES    AGE    VERSION
ip-10-0-31-216.eu-west-3.compute.internal   Ready    <none>   101m   v1.18.8-eks-7c9bda
ip-10-0-40-203.eu-west-3.compute.internal   Ready    <none>   101m   v1.18.8-eks-7c9bda
```