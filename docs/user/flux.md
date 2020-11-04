# Gitops

Portefaix Lab [gitops](https://www.weave.works/technologies/gitops/) model is [Flux v2](https://toolkit.fluxcd.io/)

![overview](../img/gitops-toolkit.png)

Initialize FLux v2 components :

```shell
❯ make flux-bootstrap ENV=dev
```

Initialize project :

```shell
❯ flux get sources git
NAME         	REVISION                                       	READY	MESSAGE
flux-system  	master/a4421d561af222a19364679705340b9d083d4ec5	True 	Fetched revision: master/a4421d561af222a19364679705340b9d083d4ec5
portefaix-lab	master/a4421d561af222a19364679705340b9d083d4ec5	True 	Fetched revision: master/a4421d561af222a19364679705340b9d083d4ec5

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