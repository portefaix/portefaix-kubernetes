# alloy

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository                            | Name                  | Version |
| ------------------------------------- | --------------------- | ------- |
| https://grafana.github.io/helm-charts | alloy-metrics(alloy)  | 0.6.0   |
| https://grafana.github.io/helm-charts | alloy-logs(alloy)     | 0.6.0   |
| https://grafana.github.io/helm-charts | alloy-traces(alloy)   | 0.6.0   |
| https://grafana.github.io/helm-charts | alloy-events(alloy)   | 0.6.0   |
| https://grafana.github.io/helm-charts | alloy-profiles(alloy) | 0.6.0   |
| https://grafana.github.io/helm-charts | alloy-frontend(alloy) | 0.6.0   |
| oci://ghcr.io/portefaix/charts        | alloy-mixin           | 0.2.0   |

## Values

| Key                                                                                 | Type   | Default                    | Description |
| ----------------------------------------------------------------------------------- | ------ | -------------------------- | ----------- |
| alloy-events.alloy.enableReporting                                                  | bool   | `false`                    |             |
| alloy-events.alloy.mode                                                             | string | `"flow"`                   |             |
| alloy-events.controller.type                                                        | string | `"deployment"`             |             |
| alloy-events.crds.create                                                            | bool   | `false`                    |             |
| alloy-events.serviceMonitor.additionalLabels."prometheus.io/operator"               | string | `"portefaix"`              |             |
| alloy-events.serviceMonitor.enabled                                                 | bool   | `true`                     |             |
| alloy-events.serviceMonitor.interval                                                | string | `"1m"`                     |             |
| alloy-events.serviceMonitor.metricRelabelings                                       | list   | `[]`                       |             |
| alloy-events.serviceMonitor.path                                                    | string | `"/metrics"`               |             |
| alloy-events.serviceMonitor.relabelings                                             | list   | `[]`                       |             |
| alloy-events.serviceMonitor.scheme                                                  | string | `"http"`                   |             |
| alloy-events.serviceMonitor.scrapeTimeout                                           | string | `"30s"`                    |             |
| alloy-frontend.alloy.enableReporting                                                | bool   | `false`                    |             |
| alloy-frontend.alloy.extraPorts[0].name                                             | string | `"faro"`                   |             |
| alloy-frontend.alloy.extraPorts[0].port                                             | int    | `12347`                    |             |
| alloy-frontend.alloy.extraPorts[0].protocol                                         | string | `"TCP"`                    |             |
| alloy-frontend.alloy.extraPorts[0].targetPort                                       | int    | `12347`                    |             |
| alloy-frontend.alloy.mode                                                           | string | `"flow"`                   |             |
| alloy-frontend.controller.type                                                      | string | `"deployment"`             |             |
| alloy-frontend.crds.create                                                          | bool   | `false`                    |             |
| alloy-frontend.serviceMonitor.additionalLabels."prometheus.io/operator"             | string | `"portefaix"`              |             |
| alloy-frontend.serviceMonitor.enabled                                               | bool   | `true`                     |             |
| alloy-frontend.serviceMonitor.interval                                              | string | `""`                       |             |
| alloy-frontend.serviceMonitor.metricRelabelings                                     | list   | `[]`                       |             |
| alloy-frontend.serviceMonitor.relabelings                                           | list   | `[]`                       |             |
| alloy-logs.alloy.enableReporting                                                    | bool   | `false`                    |             |
| alloy-logs.alloy.mode                                                               | string | `"flow"`                   |             |
| alloy-logs.controller.type                                                          | string | `"daemonset"`              |             |
| alloy-logs.crds.create                                                              | bool   | `false`                    |             |
| alloy-logs.serviceMonitor.additionalLabels."prometheus.io/operator"                 | string | `"portefaix"`              |             |
| alloy-logs.serviceMonitor.enabled                                                   | bool   | `true`                     |             |
| alloy-logs.serviceMonitor.interval                                                  | string | `"1m"`                     |             |
| alloy-logs.serviceMonitor.metricRelabelings                                         | list   | `[]`                       |             |
| alloy-logs.serviceMonitor.path                                                      | string | `"/metrics"`               |             |
| alloy-logs.serviceMonitor.relabelings                                               | list   | `[]`                       |             |
| alloy-logs.serviceMonitor.scheme                                                    | string | `"http"`                   |             |
| alloy-logs.serviceMonitor.scrapeTimeout                                             | string | `"30s"`                    |             |
| alloy-metrics.alloy.enableReporting                                                 | bool   | `false`                    |             |
| alloy-metrics.alloy.extraPorts[0].name                                              | string | `"remote-write"`           |             |
| alloy-metrics.alloy.extraPorts[0].port                                              | int    | `9090`                     |             |
| alloy-metrics.alloy.extraPorts[0].protocol                                          | string | `"TCP"`                    |             |
| alloy-metrics.alloy.extraPorts[0].targetPort                                        | int    | `9090`                     |             |
| alloy-metrics.alloy.mode                                                            | string | `"flow"`                   |             |
| alloy-metrics.alloy.mounts.extra[0].mountPath                                       | string | `"/etc/portefaix-metrics"` |             |
| alloy-metrics.alloy.mounts.extra[0].name                                            | string | `"portefaix-metrics"`      |             |
| alloy-metrics.controller.type                                                       | string | `"deployment"`             |             |
| alloy-metrics.controller.volumes.extra[0].configMap.name                            | string | `"portefaix-metrics"`      |             |
| alloy-metrics.controller.volumes.extra[0].name                                      | string | `"portefaix-metrics"`      |             |
| alloy-metrics.serviceMonitor.additionalLabels."prometheus.io/operator"              | string | `"portefaix"`              |             |
| alloy-metrics.serviceMonitor.enabled                                                | bool   | `true`                     |             |
| alloy-metrics.serviceMonitor.interval                                               | string | `""`                       |             |
| alloy-metrics.serviceMonitor.metricRelabelings                                      | list   | `[]`                       |             |
| alloy-metrics.serviceMonitor.relabelings                                            | list   | `[]`                       |             |
| alloy-mixin.additionalAnnotations                                                   | object | `{}`                       |             |
| alloy-mixin.additionalLabels."portefaix.xyz/version"                                | string | `"v0.54.0"`                |             |
| alloy-mixin.grafanaDashboard.enabled                                                | bool   | `true`                     |             |
| alloy-mixin.grafanaDashboard.folder                                                 | string | `"opentelemetry"`          |             |
| alloy-mixin.grafanaDashboard.grafanaOperator.allowCrossNamespaceImport              | bool   | `true`                     |             |
| alloy-mixin.grafanaDashboard.grafanaOperator.enabled                                | bool   | `true`                     |             |
| alloy-mixin.grafanaDashboard.grafanaOperator.matchLabels."grafana.com/dashboards"   | string | `"portefaix"`              |             |
| alloy-mixin.monitor.additionalLabels."prometheus.io/operator"                       | string | `"portefaix"`              |             |
| alloy-profiles.alloy.enableReporting                                                | bool   | `false`                    |             |
| alloy-profiles.alloy.extraPorts[0].name                                             | string | `"pyroscope"`              |             |
| alloy-profiles.alloy.extraPorts[0].port                                             | int    | `4100`                     |             |
| alloy-profiles.alloy.extraPorts[0].protocol                                         | string | `"TCP"`                    |             |
| alloy-profiles.alloy.extraPorts[0].targetPort                                       | int    | `4100`                     |             |
| alloy-profiles.alloy.extraPorts[1].name                                             | string | `"pyroscope-alloy"`        |             |
| alloy-profiles.alloy.extraPorts[1].port                                             | int    | `12347`                    |             |
| alloy-profiles.alloy.extraPorts[1].protocol                                         | string | `"TCP"`                    |             |
| alloy-profiles.alloy.extraPorts[1].targetPort                                       | int    | `12347`                    |             |
| alloy-profiles.alloy.mode                                                           | string | `"flow"`                   |             |
| alloy-profiles.alloy.stabilityLevel                                                 | string | `"public-preview"`         |             |
| alloy-profiles.controller.podAnnotations."profiles.grafana.com/cpu.port_name"       | string | `"http-metrics"`           |             |
| alloy-profiles.controller.podAnnotations."profiles.grafana.com/cpu.scrape"          | string | `"true"`                   |             |
| alloy-profiles.controller.podAnnotations."profiles.grafana.com/goroutine.port_name" | string | `"http-metrics"`           |             |
| alloy-profiles.controller.podAnnotations."profiles.grafana.com/goroutine.scrape"    | string | `"true"`                   |             |
| alloy-profiles.controller.podAnnotations."profiles.grafana.com/memory.port_name"    | string | `"http-metrics"`           |             |
| alloy-profiles.controller.podAnnotations."profiles.grafana.com/memory.scrape"       | string | `"true"`                   |             |
| alloy-profiles.controller.type                                                      | string | `"deployment"`             |             |
| alloy-profiles.crds.create                                                          | bool   | `false`                    |             |
| alloy-profiles.serviceMonitor.additionalLabels."prometheus.io/operator"             | string | `"portefaix"`              |             |
| alloy-profiles.serviceMonitor.enabled                                               | bool   | `true`                     |             |
| alloy-profiles.serviceMonitor.interval                                              | string | `""`                       |             |
| alloy-profiles.serviceMonitor.metricRelabelings                                     | list   | `[]`                       |             |
| alloy-profiles.serviceMonitor.relabelings                                           | list   | `[]`                       |             |
| alloy-traces.alloy.enableReporting                                                  | bool   | `false`                    |             |
| alloy-traces.alloy.extraPorts[0].name                                               | string | `"otlp-grpc"`              |             |
| alloy-traces.alloy.extraPorts[0].port                                               | int    | `4317`                     |             |
| alloy-traces.alloy.extraPorts[0].protocol                                           | string | `"TCP"`                    |             |
| alloy-traces.alloy.extraPorts[0].targetPort                                         | int    | `4317`                     |             |
| alloy-traces.alloy.extraPorts[1].name                                               | string | `"otlp-http"`              |             |
| alloy-traces.alloy.extraPorts[1].port                                               | int    | `4318`                     |             |
| alloy-traces.alloy.extraPorts[1].protocol                                           | string | `"TCP"`                    |             |
| alloy-traces.alloy.extraPorts[1].targetPort                                         | int    | `4318`                     |             |
| alloy-traces.alloy.mode                                                             | string | `"flow"`                   |             |
| alloy-traces.controller.type                                                        | string | `"deployment"`             |             |
| alloy-traces.crds.create                                                            | bool   | `false`                    |             |
| alloy-traces.serviceMonitor.additionalLabels."prometheus.io/operator"               | string | `"portefaix"`              |             |
| alloy-traces.serviceMonitor.enabled                                                 | bool   | `true`                     |             |
| alloy-traces.serviceMonitor.interval                                                | string | `""`                       |             |
| alloy-traces.serviceMonitor.metricRelabelings                                       | list   | `[]`                       |             |
| alloy-traces.serviceMonitor.relabelings                                             | list   | `[]`                       |             |
| ingress.enabled                                                                     | bool   | `false`                    |             |
| observability.alloy.modules.pull_frequency                                          | string | `"1h"`                     |             |
| observability.alloy.modules.revision                                                | string | `"v0.2.4"`                 |             |
| observability.cloud.aws.enabled                                                     | bool   | `false`                    |             |
| observability.cloud.azure.enabled                                                   | bool   | `false`                    |             |
| observability.cloud.digitalocean.enabled                                            | bool   | `false`                    |             |
| observability.cloud.gcp.enabled                                                     | bool   | `false`                    |             |
| observability.cloud.scaleway.enabled                                                | bool   | `false`                    |             |
| portefaixVersion                                                                    | string | `"v0.54.0"`                |             |

---

Autogenerated from chart metadata using
[helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
