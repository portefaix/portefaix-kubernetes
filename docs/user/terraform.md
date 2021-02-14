# Terraform

The [Terraform Helm provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs) could be use to deploy applications.

## Organization

Kubernetes applications configurations are located in `iac/<CLOUD PROVIDER>/kubernetes`.

## Actions

### Create

```shell
❯ make terraform-apply SERVICE=iac/<CLOUD_PROVIDER>/kubernetes/<NAMESPACE>/<APP> ENV=<ENVIRONMENT>
```

### Destroy

```shell
❯ make terraform-destroy SERVICE=iac/<CLOUD_PROVIDER>/kubernetes/<NAMESPACE>/<APP> ENV=<ENVIRONMENT>
```
