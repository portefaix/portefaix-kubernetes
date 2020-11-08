# Prometheus Operator

![prometheus-operator](../../img/prometheus-operator.png)

## Description

* Chart : [kube-prometheus-stack](https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack)
* Version: `11.0.4`

## Checks

* CRD:

```shell
❯ kubectl get crd|grep coreos
alertmanagerconfigs.monitoring.coreos.com        2020-11-08T17:11:39Z
alertmanagers.monitoring.coreos.com              2020-11-08T17:11:40Z
podmonitors.monitoring.coreos.com                2020-11-08T17:11:40Z
probes.monitoring.coreos.com                     2020-11-08T17:11:40Z
prometheuses.monitoring.coreos.com               2020-11-08T17:11:41Z
prometheusrules.monitoring.coreos.com            2020-11-08T17:11:41Z
servicemonitors.monitoring.coreos.com            2020-11-08T17:11:42Z
thanosrulers.monitoring.coreos.com               2020-11-08T17:11:42Z
```

* Deployment of the Prometheus Operator

```shell
❯ kubectl get deployments.apps -n monitoring -l app=kube-prometheus-stack-operator
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
kube-prometheus-stack-operator   1/1     1            1           26m

❯ kubectl get svc -n monitoring -l app=kube-prometheus-stack-operator
NAME                             TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
kube-prometheus-stack-operator   ClusterIP   10.40.16.153   <none>        443/TCP   27m
```
