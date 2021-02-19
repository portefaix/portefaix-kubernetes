# Linkderd2

## Description

* Chart : [linkerd2-edge](https://artifacthub.io/packages/helm/linkerd2-edge/linkerd2)
* Version: `21.1.1`

## Prerequisite

With [step](https://smallstep.com/cli/):

Generate the Linkerd trust anchor certificate:

```shell
$ step certificate create identity.linkerd.cluster.local ca.crt ca.key \
    --profile root-ca --no-password \
    --insecure \
    --san identity.linkerd.cluster.local
```

Generate the Linkerd issuer certificate and key:

```shell
$ step certificate create identity.linkerd.cluster.local issuer.crt issuer.key \
    --ca ca.crt --ca-key ca.key --profile intermediate-ca \
    --not-after 8760h --no-password --insecure \
    --san identity.linkerd.cluster.local
```

Generate a Kubernetes secret with the Linkerd certs:

```shell
$ kubectl -n linkerd create secret generic linkerd-certs \
    --from-file=ca.crt --from-file=issuer.crt \
    --from-file=issuer.key -oyaml --dry-run=client \
    > certificates.yaml
```
