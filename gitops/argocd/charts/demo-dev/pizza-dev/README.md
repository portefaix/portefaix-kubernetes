# pizza-dev

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.7.0](https://img.shields.io/badge/AppVersion-0.7.0-informational?style=flat-square)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` |  |
| pizza.additionalLabels | object | `{}` |  |
| pizza.image.digest | string | `""` |  |
| pizza.image.pullPolicy | string | `"IfNotPresent"` |  |
| pizza.image.repository | string | `"ghcr.io/grafana/quickpizza-local"` |  |
| pizza.image.tag | string | `""` |  |
| pizza.serviceMonitor.additionalLabels."prometheus.io/operator" | string | `"portefaix"` |  |
| pizza.serviceMonitor.enabled | bool | `true` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)