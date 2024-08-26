# cert-manager

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.jetstack.io | cert-manager | 1.13.5 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cert-manager.crds.enabled | bool | `false` |  |
| cert-manager.global.commonLabels."portefaix.xyz/version" | string | `"v0.54.0"` |  |
| cert-manager.prometheus.enabled | bool | `true` |  |
| cert-manager.prometheus.servicemonitor.enabled | bool | `true` |  |
| cert-manager.prometheus.servicemonitor.labels."prometheus.io/operator" | string | `"portefaix"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)