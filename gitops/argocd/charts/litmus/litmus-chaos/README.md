# litmus-chaos

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://groundhog2k.github.io/helm-charts | mongodb | 0.6.2 |
| https://litmuschaos.github.io/litmus-helm | kubernetes-chaos | 3.6.0 |
| https://litmuschaos.github.io/litmus-helm | litmus | 3.1.0 |
| https://litmuschaos.github.io/litmus-helm | litmus-core | 3.6.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.className | string | `"nginx"` |  |
| ingress.enabled | bool | `false` |  |
| ingress.name | string | `""` |  |
| kubernetes-chaos.customLabels."portefaix.xyz/version" | string | `"v0.54.0"` |  |
| litmus-core.customLabels."portefaix.xyz/version" | string | `"v0.54.0"` |  |
| litmus-core.exporter.enabled | bool | `true` |  |
| litmus-core.exporter.serviceMonitor.additionalLabels."prometheus.io/operator" | string | `"portefaix"` |  |
| litmus-core.exporter.serviceMonitor.enabled | bool | `true` |  |
| litmus.customLabels."portefaix.xyz/version" | string | `"v0.54.0"` |  |
| litmus.mongodb.enabled | bool | `false` |  |
| mongodb.image.tag | string | `"6.0.12"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
