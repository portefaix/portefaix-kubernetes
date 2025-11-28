# grafana-operator

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 6.19.1](https://img.shields.io/badge/AppVersion-6.19.1-informational?style=flat-square)

## Requirements

| Repository                        | Name             | Version |
| --------------------------------- | ---------------- | ------- |
| oci://ghcr.io/grafana/helm-charts | grafana-operator | v5.11.0 |

## Values

| Key                                                                       | Type   | Default                                                                   | Description |
| ------------------------------------------------------------------------- | ------ | ------------------------------------------------------------------------- | ----------- |
| grafana-operator.additionalLabels."portefaix.xyz/version"                 | string | `"v0.54.0"`                                                               |             |
| grafana-operator.additionalLabels.app                                     | string | `"grafana"`                                                               |             |
| grafana-operator.serviceMonitor.additionalLabels."prometheus.io/operator" | string | `"portefaix"`                                                             |             |
| grafana-operator.serviceMonitor.enabled                                   | bool   | `true`                                                                    |             |
| grafanaOperator.alerts                                                    | list   | `[]`                                                                      |             |
| grafanaOperator.datasources                                               | list   | `[]`                                                                      |             |
| grafanaOperator.folders[0]                                                | string | `"ai"`                                                                    |             |
| grafanaOperator.folders[10]                                               | string | `"portefaix"`                                                             |             |
| grafanaOperator.folders[11]                                               | string | `"reliability"`                                                           |             |
| grafanaOperator.folders[12]                                               | string | `"security"`                                                              |             |
| grafanaOperator.folders[13]                                               | string | `"storage"`                                                               |             |
| grafanaOperator.folders[14]                                               | string | `"tracing"`                                                               |             |
| grafanaOperator.folders[1]                                                | string | `"compute"`                                                               |             |
| grafanaOperator.folders[2]                                                | string | `"database"`                                                              |             |
| grafanaOperator.folders[3]                                                | string | `"finops"`                                                                |             |
| grafanaOperator.folders[4]                                                | string | `"gitops"`                                                                |             |
| grafanaOperator.folders[5]                                                | string | `"kubernetes"`                                                            |             |
| grafanaOperator.folders[6]                                                | string | `"logging"`                                                               |             |
| grafanaOperator.folders[7]                                                | string | `"monitoring"`                                                            |             |
| grafanaOperator.folders[8]                                                | string | `"networking"`                                                            |             |
| grafanaOperator.folders[9]                                                | string | `"opentelemetry"`                                                         |             |
| grafanaOperator.instance.installPlugins                                   | string | `"grafana-piechart-panel,grafana-lokiexplore-app, grafana-pyroscope-app"` |             |
| grafanaOperator.instance.name                                             | string | `"core"`                                                                  |             |
| grafanaOperator.instance.unsignedPlugins                                  | string | `"grafana-lokiexplore-app, grafana-pyroscope-app"`                        |             |
| grafanaOperator.matchLabels."grafana.com/dashboards"                      | string | `"portefaix"`                                                             |             |
| ingress.enabled                                                           | bool   | `false`                                                                   |             |

---

Autogenerated from chart metadata using
[helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
