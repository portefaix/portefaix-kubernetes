# grafana

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 6.19.1](https://img.shields.io/badge/AppVersion-6.19.1-informational?style=flat-square)

## Requirements

| Repository                        | Name          | Version |
| --------------------------------- | ------------- | ------- |
| oci://ghcr.io/grafana/helm-charts | grafana       | 7.3.10  |
| oci://ghcr.io/portefaix/charts    | grafana-mixin | 1.4.0   |

## Values

| Key                                                                                | Type   | Default                                                                               | Description |
| ---------------------------------------------------------------------------------- | ------ | ------------------------------------------------------------------------------------- | ----------- |
| grafana-mixin.additionalAnnotations                                                | object | `{}`                                                                                  |             |
| grafana-mixin.additionalLabels."portefaix.xyz/version"                             | string | `"v0.54.0"`                                                                           |             |
| grafana-mixin.grafana.folder                                                       | string | `"monitoring"`                                                                        |             |
| grafana-mixin.monitor.additionalLabels."prometheus.io/operator"                    | string | `"portefaix"`                                                                         |             |
| grafana."grafana.ini"."auth.basic".enable                                          | bool   | `false`                                                                               |             |
| grafana."grafana.ini"."auth.proxy".auto_sign_up                                    | bool   | `true`                                                                                |             |
| grafana."grafana.ini"."auth.proxy".enabled                                         | bool   | `true`                                                                                |             |
| grafana."grafana.ini"."auth.proxy".header_name                                     | string | `"X-Email"`                                                                           |             |
| grafana."grafana.ini"."auth.proxy".header_property                                 | string | `"email"`                                                                             |             |
| grafana."grafana.ini"."log.console".format                                         | string | `"json"`                                                                              |             |
| grafana."grafana.ini".auth.oauth_auto_login                                        | bool   | `true`                                                                                |             |
| grafana."grafana.ini".feature_toggles.enable                                       | string | `"traceToMetrics, tempoApmTable, tempoServiceGraph, tempoBackendSearch, tempoSearch"` |             |
| grafana."grafana.ini".log.level                                                    | string | `"info"`                                                                              |             |
| grafana."grafana.ini".log.mode                                                     | string | `"console"`                                                                           |             |
| grafana."grafana.ini".users.allow_sign_up                                          | bool   | `false`                                                                               |             |
| grafana."grafana.ini".users.auto_assign_org                                        | bool   | `true`                                                                                |             |
| grafana."grafana.ini".users.auto_assign_org_role                                   | string | `"Admin"`                                                                             |             |
| grafana.dashboardProviders."dashboardproviders.yaml".apiVersion                    | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].disableDeletion  | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].editable         | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].folder           | string | `"gitops"`                                                                            |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].name             | string | `"gitops"`                                                                            |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].options.path     | string | `"/tmp/dashboards/gitops"`                                                            |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].orgId            | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].type             | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[10].disableDeletion | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[10].editable        | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[10].folder          | string | `"storage"`                                                                           |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[10].name            | string | `"storage"`                                                                           |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[10].options.path    | string | `"/tmp/dashboards/storage"`                                                           |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[10].orgId           | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[10].type            | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[11].disableDeletion | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[11].editable        | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[11].folder          | string | `"networking"`                                                                        |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[11].name            | string | `"networking"`                                                                        |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[11].options.path    | string | `"/tmp/dashboards/networking"`                                                        |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[11].orgId           | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[11].type            | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[12].disableDeletion | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[12].editable        | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[12].folder          | string | `"databases"`                                                                         |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[12].name            | string | `"databases"`                                                                         |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[12].options.path    | string | `"/tmp/dashboards/databases"`                                                         |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[12].orgId           | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[12].type            | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[13].disableDeletion | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[13].editable        | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[13].folder          | string | `"finops"`                                                                            |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[13].name            | string | `"finops"`                                                                            |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[13].options.path    | string | `"/tmp/dashboards/finops"`                                                            |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[13].orgId           | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[13].type            | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[14].disableDeletion | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[14].editable        | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[14].folder          | string | `"ai"`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[14].name            | string | `"ai"`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[14].options.path    | string | `"/tmp/dashboards/ai"`                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[14].orgId           | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[14].type            | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[15].disableDeletion | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[15].editable        | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[15].folder          | string | `"portefaix"`                                                                         |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[15].name            | string | `"portefaix"`                                                                         |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[15].options.path    | string | `"/tmp/dashboards/portefaix"`                                                         |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[15].orgId           | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[15].type            | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].disableDeletion  | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].editable         | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].folder           | string | `"compute"`                                                                           |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].name             | string | `"compute"`                                                                           |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].options.path     | string | `"/tmp/dashboards/compute"`                                                           |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].orgId            | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].type             | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].disableDeletion  | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].editable         | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].folder           | string | `"kubernetes"`                                                                        |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].name             | string | `"kubernetes"`                                                                        |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].options.path     | string | `"/tmp/dashboards/kubernetes"`                                                        |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].orgId            | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].type             | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].disableDeletion  | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].editable         | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].folder           | string | `"monitoring"`                                                                        |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].name             | string | `"monitoring"`                                                                        |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].options.path     | string | `"/tmp/dashboards/monitoring"`                                                        |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].orgId            | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].type             | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].disableDeletion  | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].editable         | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].folder           | string | `"logging"`                                                                           |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].name             | string | `"logging"`                                                                           |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].options.path     | string | `"/tmp/dashboards/logging"`                                                           |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].orgId            | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].type             | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].disableDeletion  | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].editable         | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].folder           | string | `"tracing"`                                                                           |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].name             | string | `"tracing"`                                                                           |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].options.path     | string | `"/tmp/dashboards/tracing"`                                                           |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].orgId            | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].type             | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].disableDeletion  | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].editable         | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].folder           | string | `"opentelemetry"`                                                                     |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].name             | string | `"opentelemetry"`                                                                     |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].options.path     | string | `"/tmp/dashboards/opentelemetry"`                                                     |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].orgId            | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].type             | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].disableDeletion  | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].editable         | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].folder           | string | `"profiling"`                                                                         |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].name             | string | `"profiling"`                                                                         |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].options.path     | string | `"/tmp/dashboards/profiling"`                                                         |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].orgId            | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].type             | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].disableDeletion  | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].editable         | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].folder           | string | `"security"`                                                                          |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].name             | string | `"security"`                                                                          |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].options.path     | string | `"/tmp/dashboards/security"`                                                          |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].orgId            | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].type             | string | `"file"`                                                                              |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].disableDeletion  | bool   | `true`                                                                                |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].editable         | bool   | `false`                                                                               |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].folder           | string | `"reliability"`                                                                       |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].name             | string | `"reliability"`                                                                       |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].options.path     | string | `"/tmp/dashboards/reliability"`                                                       |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].orgId            | int    | `1`                                                                                   |             |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].type             | string | `"file"`                                                                              |             |
| grafana.dashboardsConfigMaps                                                       | object | `{}`                                                                                  |             |
| grafana.env.GF_AUTH_ANONYMOUS_ENABLED                                              | string | `"true"`                                                                              |             |
| grafana.env.GF_AUTH_ANONYMOUS_ORG_ROLE                                             | string | `"Admin"`                                                                             |             |
| grafana.env.GF_AUTH_DISABLE_LOGIN_FORM                                             | string | `"true"`                                                                              |             |
| grafana.env.GF_DIAGNOSTICS_PROFILING_ADDR                                          | string | `"0.0.0.0"`                                                                           |             |
| grafana.env.GF_DIAGNOSTICS_PROFILING_ENABLED                                       | string | `"true"`                                                                              |             |
| grafana.env.GF_DIAGNOSTICS_PROFILING_PORT                                          | string | `"6060"`                                                                              |             |
| grafana.env.GF_FEATURE_TOGGLES_ENABLE                                              | string | `"flameGraph"`                                                                        |             |
| grafana.extraLabels."portefaix.xyz/version"                                        | string | `"v0.54.0"`                                                                           |             |
| grafana.plugins[0]                                                                 | string | `"grafana-piechart-panel"`                                                            |             |
| grafana.plugins[1]                                                                 | string | `"grafana-worldmap-panel"`                                                            |             |
| grafana.plugins[2]                                                                 | string | `"grafana-clock-panel"`                                                               |             |
| grafana.plugins[3]                                                                 | string | `"raintank-worldping-app"`                                                            |             |
| grafana.plugins[4]                                                                 | string | `"isovalent-hubble-datasource"`                                                       |             |
| grafana.plugins[5]                                                                 | string | `"quickwit-quickwit-datasource"`                                                      |             |
| grafana.rbac.pspEnabled                                                            | bool   | `false`                                                                               |             |
| grafana.serviceAccount.create                                                      | bool   | `true`                                                                                |             |
| grafana.serviceAccount.name                                                        | string | `"grafana"`                                                                           |             |
| grafana.serviceMonitor.enabled                                                     | bool   | `true`                                                                                |             |
| grafana.serviceMonitor.labels."prometheus.io/operator"                             | string | `"portefaix"`                                                                         |             |
| grafana.sidecar.alerts.enabled                                                     | bool   | `true`                                                                                |             |
| grafana.sidecar.alerts.label                                                       | string | `"grafana.com/alert"`                                                                 |             |
| grafana.sidecar.alerts.searchNamespace                                             | string | `"ALL"`                                                                               |             |
| grafana.sidecar.dashboards.SCProvider                                              | bool   | `false`                                                                               |             |
| grafana.sidecar.dashboards.enabled                                                 | bool   | `true`                                                                                |             |
| grafana.sidecar.dashboards.folder                                                  | string | `"/tmp/dashboards"`                                                                   |             |
| grafana.sidecar.dashboards.folderAnnotation                                        | string | `"grafana.com/folder"`                                                                |             |
| grafana.sidecar.dashboards.label                                                   | string | `"grafana.com/dashboard"`                                                             |             |
| grafana.sidecar.dashboards.provider.foldersFromFilesStructure                      | bool   | `true`                                                                                |             |
| grafana.sidecar.dashboards.searchNamespace                                         | string | `"ALL"`                                                                               |             |
| grafana.sidecar.datasources.defaultDatasourceEnabled                               | bool   | `false`                                                                               |             |
| grafana.sidecar.datasources.enabled                                                | bool   | `true`                                                                                |             |
| grafana.sidecar.datasources.label                                                  | string | `"grafana.com/datasource"`                                                            |             |
| grafana.sidecar.datasources.searchNamespace                                        | string | `"ALL"`                                                                               |             |
| grafana.sidecar.logLevel                                                           | string | `"INFO"`                                                                              |             |
| grafana.sidecar.notifiers.enabled                                                  | bool   | `true`                                                                                |             |
| grafana.sidecar.notifiers.label                                                    | string | `"grafana.com/notifier"`                                                              |             |
| grafana.sidecar.notifiers.searchNamespace                                          | string | `"ALL"`                                                                               |             |
| grafana.sidecar.plugins.enabled                                                    | bool   | `true`                                                                                |             |
| grafana.sidecar.plugins.labels                                                     | string | `"grafana.com/plugin"`                                                                |             |
| grafana.sidecar.plugins.searchNamespace                                            | string | `"ALL"`                                                                               |             |
| grafana.testFramework.enabled                                                      | bool   | `false`                                                                               |             |
| image.tag                                                                          | string | `""`                                                                                  |             |
| ingress.enabled                                                                    | bool   | `false`                                                                               |             |

---

Autogenerated from chart metadata using
[helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
