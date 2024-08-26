# descheduler

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-sigs.github.io/descheduler | descheduler | 0.28.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| descheduler.commonLabels."portefaix.xyz/version" | string | `"v0.54.0"` |  |
| descheduler.deschedulingInterval | string | `"5m"` |  |
| descheduler.kind | string | `"CronJob"` |  |
| descheduler.resources | object | `{}` |  |
| descheduler.schedule | string | `"*/10 * * * *"` |  |
| descheduler.service.enabled | bool | `true` |  |
| descheduler.serviceMonitor.additionalLabels."prometheus.io/operator" | string | `"portefaix"` |  |
| descheduler.serviceMonitor.enabled | bool | `true` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)