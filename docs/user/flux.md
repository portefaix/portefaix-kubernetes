# Gitops

[Gitops](https://www.weave.works/technologies/gitops/) model used is [Flux v2](https://toolkit.fluxcd.io/)

![overview](../img/gitops-toolkit.png)

## Flux

Initialize FLux v2 components :

```shell
❯ make gitops-bootstrap ENV=prod
```

Initialize project :

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

```
❯ kubectl create secret generic slack-webhook-url --namespace=flux-system \
--from-literal=address=https://hooks.slack.com/services/XXXXXXXX/XXXXX --dry-run=client -o yaml > slack-webhook-url.yaml
```

Set the Kubeseal secret :

```
❯ make kubernetes-secret CERT=config/pub-sealed-secrets.pem FILE=slack-webhook-url.yaml
❯ mv slack-webhook-url-sealed.yaml kubernetes/flux-system/notifications/
❯ rm slack-webhook-url.yaml
```

## Setup cluster

On development environment, we target master branch on the git source:

```yaml
---
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: GitRepository
metadata:
  name: portefaix-lab
  namespace: flux-system
spec:
  interval: 30s
  ref:
    branch: master
  url: https://github.com/nlamirault/portefaix-lab
```

On production clusters, when we creates the git source we specify a semver
expression :

```yaml
---
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: GitRepository
metadata:
  name: portefaix-lab
  namespace: flux-system
spec:
  interval: 30s
  ref:
    semver: '>=1.0.0 <2.0.0'
  url: https://github.com/nlamirault/portefaix-lab
```

```shell
❯ make gitops-init ENV=prod


❯ flux get sources git
NAME            REVISION                                        READY   MESSAGE
flux-system     master/27ebc142e1e79a4466f3eec14e6c2e36464ffc4f True    Fetched revision: master/27ebc142e1e79a4466f3eec14e6c2e36464ffc4f
portefaix-lab   master/27ebc142e1e79a4466f3eec14e6c2e36464ffc4f True    Fetched revision: master/27ebc142e1e79a4466f3eec14e6c2e36464ffc4f
```

