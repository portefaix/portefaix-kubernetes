# Flux Monitoring

![flux-monitoring](../../img/flux-monitoring.png)

## Description



## Checks

* Pod Monitors:

```shell
❯ kubectl get podmonitors.monitoring.coreos.com -n flux-system
NAME                      AGE
helm-controller           20m
kustomize-controller      20m
notification-controller   20m
source-controller         20m
```
