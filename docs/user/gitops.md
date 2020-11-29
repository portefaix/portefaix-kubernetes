# Gitops

[Gitops](https://www.weave.works/technologies/gitops/) model used is [Flux v2](https://toolkit.fluxcd.io/)

![overview](../img/gitops-toolkit.png)

## Organization

Manifests files :

* `kubernetes/base` directory contains manifests for all components
* `kubernetes/overlays/**` directory contains [Kustomize](https://kustomize.io/) overlays

Flux components are deployed for each clusster on `clusters/<CLOUD>/<ENV>/` :

* `clusters/<CLOUD>/<ENV>/flux-system` : Flux core components
* `clusters/<CLOUD>/<ENV>/*.yaml` : [Flux Kustomization](https://toolkit.fluxcd.io/components/kustomize/kustomization/) files for components

## Secrets

[Sops](https://github.com/mozilla/sops) is used to manage secrets.

### Store

Put your sensitive data into the directory `.secrets` or `.secrets/<CLOUD_PROVIDER>`

### Kubernetes secret

Create a Kubernetes secret file from sensitive file.

Ex: for Thanos configuration :

```yaml
❯ cat .secrets/aws/object-store.yaml
type: S3
config:
  bucket: xxxxxxxxxxx
  endpoint: s3.eu-west-3.amazonaws.com
  region: eu-west-3
```

```shell
❯ make kubernetes-secret NAME=thanos-object-storage NAMESPACE=monitoring FILE=.secrets/aws/object-store.yaml > thanos-object-storage.yaml
```

### Encrypt

Encrypt the file using Sops:

```shell
❯ make sops-encrypt ENV=staging CLOUD=aws FILE=thanos-object-storage.yaml
```

You can now safely store this file into Git.

```shell
❯ mv thanos-object-storage.yaml kubernetes/overlays/staging/monitoring/thanos/
```

### Decrypt

Check you can decrypt the file:

```shell
❯ make sops-decrypt FILE=kubernetes/overlays/staging/monitoring/thanos/thanos-object-storage.yaml
apiVersion: v1
data:
    object-store.yaml: xxxxxxxxxxx
kind: Secret
metadata:
    creationTimestamp: null
    name: thanos-object-storage
    namespace: monitoring
```

### Store