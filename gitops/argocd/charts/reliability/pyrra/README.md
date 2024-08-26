# pyyra

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://rlex.github.io/helm-charts | pyrra | 0.10.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| grafanaDashboard.enabled | bool | `true` |  |
| grafanaDashboard.grafanaOperator.enabled | bool | `true` |  |
| grafanaDashboard.grafanaOperator.matchLabels."grafana.com/dashboards" | string | `"portefaix"` |  |
| ingress.enabled | bool | `false` |  |
| pyrra.additionalLabels."portefaix.xyz/version" | string | `"v0.54.0"` |  |
| pyrra.genericRules.enabled | bool | `true` |  |
| pyrra.resources | object | `{}` |  |
| pyrra.serviceMonitor.enabled | bool | `true` |  |
| pyrra.serviceMonitor.jobLabel | string | `"pyrra"` |  |
| pyrra.serviceMonitor.labels."prometheus.io/operator" | string | `"portefaix"` |  |
| sloLabels.reliability | string | `"slo"` |  |
| sloLabels.role | string | `"alert-rules"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)