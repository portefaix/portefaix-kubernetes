# freebox-exporter

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/portefaix/charts | prometheus-freebox-exporter | 0.1.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| prometheus-freebox-exporter.additionalLabels."portefaix.xyz/version" | string | `"v0.54.0"` |  |
| prometheus-freebox-exporter.serviceMonitor.additionalLabels."prometheus.io/operator" | string | `"portefaix"` |  |
| prometheus-freebox-exporter.serviceMonitor.enabled | bool | `true` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
