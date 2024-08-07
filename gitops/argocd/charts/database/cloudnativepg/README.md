# cloudnative-pg

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/cloudnative-pg/charts | cloudnative-pg | 0.21.5 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cloudnative-pg.monitoring.grafanaDashboard.annotations."grafana.com/folder" | string | `"database"` |  |
| cloudnative-pg.monitoring.grafanaDashboard.configMapName | string | `"dashboard-cnpg"` |  |
| cloudnative-pg.monitoring.grafanaDashboard.create | bool | `true` |  |
| cloudnative-pg.monitoring.grafanaDashboard.labels."grafana.com/dashboard" | string | `"cnpg-overview"` |  |
| cloudnative-pg.monitoring.podMonitorAdditionalLabels."prometheus.io/operator" | string | `"portefaix"` |  |
| cloudnative-pg.monitoring.podMonitorEnabled | bool | `true` |  |
| grafanaDashboard.enabled | bool | `true` |  |
| grafanaDashboard.grafanaOperator.enabled | bool | `true` |  |
| grafanaDashboard.grafanaOperator.matchLabels."grafana.com/dashboards" | string | `"portefaix"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
