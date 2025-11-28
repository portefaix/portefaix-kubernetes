# falco

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository                         | Name  | Version |
| ---------------------------------- | ----- | ------- |
| oci://ghcr.io/falcosecurity/charts | falco | 4.6.0   |

## Values

| Key                                                                          | Type   | Default                                 | Description |
| ---------------------------------------------------------------------------- | ------ | --------------------------------------- | ----------- |
| falco.collectors.containerd.enabled                                          | bool   | `false`                                 |             |
| falco.collectors.crio.enabled                                                | bool   | `false`                                 |             |
| falco.collectors.docker.enabled                                              | bool   | `false`                                 |             |
| falco.collectors.enabled                                                     | bool   | `true`                                  |             |
| falco.collectors.kubernetes.enabled                                          | bool   | `true`                                  |             |
| falco.controller.deployment.replicas                                         | int    | `1`                                     |             |
| falco.controller.kind                                                        | string | `"deployment"`                          |             |
| falco.driver.enabled                                                         | bool   | `false`                                 |             |
| falco.falcoctl.artifact.follow.enabled                                       | bool   | `true`                                  |             |
| falco.falcoctl.artifact.install.enabled                                      | bool   | `true`                                  |             |
| falco.falcoctl.config.artifact.allowedTypes[0]                               | string | `"plugin"`                              |             |
| falco.falcoctl.config.artifact.allowedTypes[1]                               | string | `"rulesfile"`                           |             |
| falco.falcoctl.config.artifact.follow.refs[0]                                | string | `"falco-rules:3"`                       |             |
| falco.falcoctl.config.artifact.follow.refs[1]                                | string | `"k8saudit-rules:0"`                    |             |
| falco.falcoctl.config.artifact.follow.refs[2]                                | string | `"json:0"`                              |             |
| falco.falcoctl.config.artifact.install.refs[0]                               | string | `"falco-rules:3"`                       |             |
| falco.falcoctl.config.artifact.install.refs[1]                               | string | `"k8saudit-rules:0"`                    |             |
| falco.falcoctl.config.artifact.install.refs[2]                               | string | `"k8saudit:0"`                          |             |
| falco.falcoctl.config.artifact.install.refs[3]                               | string | `"json:0"`                              |             |
| falco.falcoctl.config.artifact.install.resolveDeps                           | bool   | `true`                                  |             |
| falco.falcosidekick.enabled                                                  | bool   | `true`                                  |             |
| falco.falcosidekick.prometheusRules.alerts.additionalAlerts                  | object | `{}`                                    |             |
| falco.falcosidekick.prometheusRules.alerts.alert.enabled                     | bool   | `true`                                  |             |
| falco.falcosidekick.prometheusRules.alerts.alert.rate_interval               | string | `"5m"`                                  |             |
| falco.falcosidekick.prometheusRules.alerts.alert.threshold                   | int    | `0`                                     |             |
| falco.falcosidekick.prometheusRules.alerts.critical.enabled                  | bool   | `true`                                  |             |
| falco.falcosidekick.prometheusRules.alerts.critical.rate_interval            | string | `"5m"`                                  |             |
| falco.falcosidekick.prometheusRules.alerts.critical.threshold                | int    | `0`                                     |             |
| falco.falcosidekick.prometheusRules.alerts.emergency.enabled                 | bool   | `true`                                  |             |
| falco.falcosidekick.prometheusRules.alerts.emergency.rate_interval           | string | `"5m"`                                  |             |
| falco.falcosidekick.prometheusRules.alerts.emergency.threshold               | int    | `0`                                     |             |
| falco.falcosidekick.prometheusRules.alerts.error.enabled                     | bool   | `true`                                  |             |
| falco.falcosidekick.prometheusRules.alerts.error.rate_interval               | string | `"5m"`                                  |             |
| falco.falcosidekick.prometheusRules.alerts.error.threshold                   | int    | `0`                                     |             |
| falco.falcosidekick.prometheusRules.alerts.output.enabled                    | bool   | `true`                                  |             |
| falco.falcosidekick.prometheusRules.alerts.output.rate_interval              | string | `"5m"`                                  |             |
| falco.falcosidekick.prometheusRules.alerts.output.threshold                  | int    | `0`                                     |             |
| falco.falcosidekick.prometheusRules.alerts.warning.enabled                   | bool   | `true`                                  |             |
| falco.falcosidekick.prometheusRules.alerts.warning.rate_interval             | string | `"5m"`                                  |             |
| falco.falcosidekick.prometheusRules.alerts.warning.threshold                 | int    | `0`                                     |             |
| falco.falcosidekick.prometheusRules.enabled                                  | bool   | `true`                                  |             |
| falco.falcosidekick.serviceMonitor.additionalLabels."prometheus.io/operator" | string | `"portefaix"`                           |             |
| falco.falcosidekick.serviceMonitor.enabled                                   | bool   | `true`                                  |             |
| falco.falcosidekick.webui.enabled                                            | bool   | `false`                                 |             |
| falco.k8s-metacollector.grafana.dashboards.configMaps.collector.folder       | string | `"security"`                            |             |
| falco.k8s-metacollector.grafana.dashboards.enabled                           | bool   | `true`                                  |             |
| falco.k8s-metacollector.serviceMonitor.create                                | bool   | `true`                                  |             |
| falco.k8s-metacollector.serviceMonitor.labels."prometheus.io/operator"       | string | `"portefaix"`                           |             |
| falco.metrics.enabled                                                        | bool   | `true`                                  |             |
| falco.serviceMonitor.create                                                  | bool   | `true`                                  |             |
| falco.serviceMonitor.labels."prometheus.io/operator"                         | string | `"portefaix"`                           |             |
| falco.services[0].name                                                       | string | `"k8saudit-webhook"`                    |             |
| falco.services[0].ports[0].nodePort                                          | int    | `30007`                                 |             |
| falco.services[0].ports[0].port                                              | int    | `9765`                                  |             |
| falco.services[0].ports[0].protocol                                          | string | `"TCP"`                                 |             |
| falco.services[0].type                                                       | string | `"NodePort"`                            |             |
| grafanaDashboard.grafanaOperator.enabled                                     | bool   | `true`                                  |             |
| grafanaDashboard.grafanaOperator.existingDashboards[0].folder                | string | `"security"`                            |             |
| grafanaDashboard.grafanaOperator.existingDashboards[0].name                  | string | `"k8s-metacollector-grafana-dashboard"` |             |
| grafanaDashboard.grafanaOperator.matchLabels."grafana.com/dashboards"        | string | `"portefaix"`                           |             |
| ingress.enabled                                                              | bool   | `false`                                 |             |

---

Autogenerated from chart metadata using
[helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
