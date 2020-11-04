# Azure

## Infrastructure

Infrastructure As Code for Portefaix using Azure is in
`iac/azure` directory

!!!hint "Prerequisites"
    A project created on Azure

    Edit `iac/azure/azure.prod.mk` or add another file named :
    **iac/azure/azure.<ENVIRONMENT>.mk**

!!!warning "WIP"
    Work In Progress

## Access

Configure kubectl

```shell
❯ make azure-kube-credentials ENV=prod
```

```shell
❯ kubectl get nodes

```

