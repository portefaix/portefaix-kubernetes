# kube-bench-adapter

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://nirmata.github.io/kyverno-charts | kube-bench-adapter | 1.1.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kube-bench-adapter.kubeBench.namespace | string | `"security"` |  |
| kube-bench-adapter.service.port | int | `80` |  |
| kube-bench-adapter.service.type | string | `"ClusterIP"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
