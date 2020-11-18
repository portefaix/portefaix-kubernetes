# Gitops

[Gitops](https://www.weave.works/technologies/gitops/) model used is [Flux v2](https://toolkit.fluxcd.io/)

![overview](../img/gitops-toolkit.png)

## Setup cluster

* `kubernetes/base` directory contains manifests for all components
* `kubernetes/overlays/**` directory contains [Kustomize](https://kustomize.io/) overlays

Flux components are deployed for each clusster on `clusters/<CLOUD>/<ENV>/` :

* `clusters/<CLOUD>/<ENV>/flux-system` : Flux core components
* `clusters/<CLOUD>/<ENV>/*.yaml` : [Flux Kustomization](https://toolkit.fluxcd.io/components/kustomize/kustomization/) files for components

Example : on local environment, we target `kubernetes/overlays/local` directory on
the git source:

```yaml
---
apiVersion: kustomize.toolkit.fluxcd.io/v1beta1
kind: Kustomization
metadata:
  name: flux-system-charts
  namespace: flux-system
spec:
  interval: 10m0s
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: ./kubernetes/overlays/local/flux-system/charts
  prune: true
  validation: client
```

Initialize:

```shell
❯ make gitops-bootstrap CLOUD=kind ENV=local
```

Checks

```shell
❯ flux get sources git
NAME         	REVISION                                       	READY	MESSAGE
flux-system  	master/a4421d561af222a19364679705340b9d083d4ec5	True 	Fetched revision: master/a4421d561af222a19364679705340b9d083d4ec5

❯ flux get sources helm
NAME                            REVISION                                READY   MESSAGE
banzaicloud-charts              2020-10-30T13:43:37Z                    True    Fetched revision: 2020-10-30T13:43:37Z
flagger-charts                  2020-09-29T06:49:17.983264392Z          True    Fetched revision: 2020-09-29T06:49:17.983264392Z
grafana-loki-charts             2020-10-28T19:01:32.896983804Z          True    Fetched revision: 2020-10-28T19:01:32.896983804Z
jetstack                        2020-10-29T16:02:08Z                    True    Fetched revision: 2020-10-29T16:02:08Z
k8s-at-home-charts              2019-12-22T07:05:20.914237208Z          True    Fetched revision: 2019-12-22T07:05:20.914237208Z
kubernetes-incubator-charts     2020-10-30T16:13:47.08513541Z           True    Fetched revision: 2020-10-30T16:13:47.08513541Z
kubernetes-stable-charts        2020-10-30T15:57:54.773332885Z          True    Fetched revision: 2020-10-30T15:57:54.773332885Z
openfaas-charts                 2020-09-21T10:54:01.274831+01:00        True    Fetched revision: 2020-09-21T10:54:01.274831+01:00
podinfo                         2020-10-28T10:09:58.648748663Z          True    Fetched revision: 2020-10-28T10:09:58.648748663Z
prometheus-community-charts     2020-09-27T05:31:40.762116-04:00        True    Fetched revision: 2020-09-27T05:31:40.762116-04:00
```

## Notifications

### Slack

Using your Slack webhook URL, create a Kubernetes secret YAML file :

```shell
❯ kubectl create secret generic slack-webhook-url --namespace=flux-system \
--from-literal=address=https://hooks.slack.com/services/XXXXXXXX/XXXXX --dry-run=client -o yaml > slack-webhook-url.yaml
```

Set the Kubeseal secret :

```shell
❯ make kubernetes-secret CERT=config/pub-sealed-secrets.pem FILE=slack-webhook-url.yaml
❯ mv slack-webhook-url-sealed.yaml kubernetes/flux-system/notifications/
❯ rm slack-webhook-url.yaml
```

```shell
❯ flux get alert-providers
NAME            READY   MESSAGE
slack-portefaix True    Initialized
```

