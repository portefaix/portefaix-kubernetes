# speedtest-exporter

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://k8s-at-home.com/charts/ | speedtest-exporter | 5.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| grafanaDashboard.enabled | bool | `true` |  |
| grafanaDashboard.grafanaOperator.enabled | bool | `true` |  |
| grafanaDashboard.grafanaOperator.matchLabels."grafana.com/dashboards" | string | `"portefaix"` |  |
| speedtest-exporter.metrics.enabled | bool | `true` |  |
| speedtest-exporter.metrics.interval | string | `"5m"` |  |
| speedtest-exporter.metrics.serviceMonitor.labels."prometheus.io/operator" | string | `"portefaix"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
