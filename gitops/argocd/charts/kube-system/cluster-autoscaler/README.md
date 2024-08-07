# cluster-autoscaler

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 9.10.8](https://img.shields.io/badge/AppVersion-9.10.8-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes.github.io/autoscaler | cluster-autoscaler | 9.19.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cluster-autoscaler.prometheusRule.additionalLabels."prometheus.io/operator" | string | `"portefaix"` |  |
| cluster-autoscaler.prometheusRule.enabled | bool | `true` |  |
| cluster-autoscaler.prometheusRule.namespace | string | `"monitoring"` |  |
| cluster-autoscaler.serviceMonitor.enabled | bool | `true` |  |
| cluster-autoscaler.serviceMonitor.namespace | string | `"monitoring"` |  |
| cluster-autoscaler.serviceMonitor.selector."prometheus.io/operator" | string | `"portefaix"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
