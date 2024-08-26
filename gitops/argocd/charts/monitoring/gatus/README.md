# test-gatus

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://minicloudlabs.github.io/helm-charts | gatus | 3.1.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| gatus.extraLabels."portefaix.xyz/version" | string | `"v0.54.0"` |  |
| grafanaDashboard.enabled | bool | `true` |  |
| grafanaDashboard.grafanaOperator.enabled | bool | `true` |  |
| grafanaDashboard.grafanaOperator.matchLabels."grafana.com/dashboards" | string | `"portefaix"` |  |
| image.tag | string | `""` |  |
| ingress.enabled | bool | `false` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)