# vault

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository                          | Name  | Version |
| ----------------------------------- | ----- | ------- |
| https://helm.releases.hashicorp.com | vault | 0.27.0  |

## Values

| Key                                                                     | Type   | Default                                                                          | Description |
| ----------------------------------------------------------------------- | ------ | -------------------------------------------------------------------------------- | ----------- |
| grafanaDashboard.enabled                                                | bool   | `true`                                                                           |             |
| grafanaDashboard.grafanaOperator.enabled                                | bool   | `true`                                                                           |             |
| grafanaDashboard.grafanaOperator.matchLabels."grafana.com/dashboards"   | string | `"portefaix"`                                                                    |             |
| ingress.enabled                                                         | bool   | `false`                                                                          |             |
| vault.csi.agent.enabled                                                 | bool   | `true`                                                                           |             |
| vault.csi.agent.logFormat                                               | string | `"json"`                                                                         |             |
| vault.csi.agent.logLevel                                                | string | `"info"`                                                                         |             |
| vault.csi.enabled                                                       | bool   | `true`                                                                           |             |
| vault.global.serverTelemetry.prometheusOperator                         | bool   | `true`                                                                           |             |
| vault.injector.enabled                                                  | bool   | `true`                                                                           |             |
| vault.injector.logFormat                                                | string | `"json"`                                                                         |             |
| vault.injector.logLevel                                                 | string | `"info"`                                                                         |             |
| vault.injector.metrics.enabled                                          | bool   | `true`                                                                           |             |
| vault.server.enabled                                                    | bool   | `true`                                                                           |             |
| vault.server.logFormat                                                  | string | `"json"`                                                                         |             |
| vault.server.logLevel                                                   | string | `"info"`                                                                         |             |
| vault.serverTelemetry.prometheusRules.enabled                           | bool   | `true`                                                                           |             |
| vault.serverTelemetry.prometheusRules.rules[0].alert                    | string | `"vault-HighResponseTime"`                                                       |             |
| vault.serverTelemetry.prometheusRules.rules[0].annotations.message      | string | `"The response time of Vault is over 500ms on average over the last 5 minutes."` |             |
| vault.serverTelemetry.prometheusRules.rules[0].expr                     | string | `"vault_core_handle_request{quantile=\"0.5\"} > 500"`                            |             |
| vault.serverTelemetry.prometheusRules.rules[0].for                      | string | `"5m"`                                                                           |             |
| vault.serverTelemetry.prometheusRules.rules[0].labels.severity          | string | `"warning"`                                                                      |             |
| vault.serverTelemetry.prometheusRules.rules[1].alert                    | string | `"vault-HighResponseTime"`                                                       |             |
| vault.serverTelemetry.prometheusRules.rules[1].annotations.message      | string | `"The response time of Vault is over 1s on average over the last 5 minutes."`    |             |
| vault.serverTelemetry.prometheusRules.rules[1].expr                     | string | `"vault_core_handle_request{quantile=\"0.5\"} > 1000"`                           |             |
| vault.serverTelemetry.prometheusRules.rules[1].for                      | string | `"5m"`                                                                           |             |
| vault.serverTelemetry.prometheusRules.rules[1].labels.severity          | string | `"critical"`                                                                     |             |
| vault.serverTelemetry.serviceMonitor.enabled                            | bool   | `true`                                                                           |             |
| vault.serverTelemetry.serviceMonitor.selectors."prometheus.io/operator" | string | `"portefaix"`                                                                    |             |
| vault.ui.enabled                                                        | bool   | `true`                                                                           |             |

---

Autogenerated from chart metadata using
[helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
