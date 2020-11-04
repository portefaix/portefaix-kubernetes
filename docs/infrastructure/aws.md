# Amazon AWS

## Infrastructure

Infrastructure As Code for Portefaix using Amazon AWS is in
`iac/aws` directory

!!!hint "Prerequisites"
    A project created on Amazon AWS

    Edit `iac/aws/aws.prod.mk` or add another file named :
    **iac/aws/aws.<ENVIRONMENT>.mk**

!!!warning "WIP"
    Work In Progress

## Access

Configure kubectl

```shell
❯ make aws-kube-credentials ENV=prod
```

```shell
❯ kubectl get nodes

```

