# policy-reporter

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository                                | Name            | Version |
| ----------------------------------------- | --------------- | ------- |
| https://kyverno.github.io/policy-reporter | policy-reporter | 2.23.1  |

## Values

| Key                                                                           | Type   | Default                            | Description |
| ----------------------------------------------------------------------------- | ------ | ---------------------------------- | ----------- |
| global.labels                                                                 | object | `{}`                               |             |
| ingress.enabled                                                               | bool   | `false`                            |             |
| policy-reporter.global.labels."portefaix.xyz/version"                         | string | `"v0.54.0"`                        |             |
| policy-reporter.grafana.dashboards.enabled                                    | bool   | `true`                             |             |
| policy-reporter.grafana.dashboards.label                                      | string | `"grafana.com/dashboard"`          |             |
| policy-reporter.grafana.enable.clusterPolicyReportDetails                     | bool   | `true`                             |             |
| policy-reporter.grafana.enable.overview                                       | bool   | `true`                             |             |
| policy-reporter.grafana.enable.policyReportDetails                            | bool   | `true`                             |             |
| policy-reporter.grafana.folder.annotation                                     | string | `"grafana.com/folder"`             |             |
| policy-reporter.grafana.folder.name                                           | string | `"security"`                       |             |
| policy-reporter.grafana.grafanaDashboard.allowCrossNamespaceImport            | bool   | `true`                             |             |
| policy-reporter.grafana.grafanaDashboard.create                               | bool   | `true`                             |             |
| policy-reporter.grafana.grafanaDashboard.folder                               | string | `"security"`                       |             |
| policy-reporter.grafana.grafanaDashboard.matchLabels."grafana.com/dashboards" | string | `"portefaix"`                      |             |
| policy-reporter.grafana.multicluster.enabled                                  | bool   | `true`                             |             |
| policy-reporter.grafana.multicluster.label                                    | string | `"cluster"`                        |             |
| policy-reporter.kyvernoPlugin.enabled                                         | bool   | `true`                             |             |
| policy-reporter.logging.encoding                                              | string | `"json"`                           |             |
| policy-reporter.logging.logLevel                                              | int    | `0`                                |             |
| policy-reporter.metrics.enabled                                               | bool   | `true`                             |             |
| policy-reporter.monitoring.enabled                                            | bool   | `true`                             |             |
| policy-reporter.monitoring.plugins.kyverno                                    | bool   | `true`                             |             |
| policy-reporter.monitoring.serviceMonitor.labels."prometheus.io/operator"     | string | `"portefaix"`                      |             |
| policy-reporter.target.ui.host                                                | string | `"http://policy-reporter-ui:8080"` |             |
| policy-reporter.target.ui.minimumPriority                                     | string | `"warning"`                        |             |
| policy-reporter.target.ui.skipExistingOnStartup                               | bool   | `true`                             |             |
| policy-reporter.target.ui.sources[0]                                          | string | `"kyverno"`                        |             |
| policy-reporter.ui.enabled                                                    | bool   | `true`                             |             |
| policy-reporter.ui.logging.encoding                                           | string | `"json"`                           |             |
| policy-reporter.ui.logging.logLevel                                           | int    | `0`                                |             |

---

Autogenerated from chart metadata using
[helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
