# keda

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kedacore.github.io/charts | keda | 2.15.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| keda.additionalLabels."portefaix.xyz/version" | string | `"v0.54.0"` |  |
| keda.logging.metricsServer.level | int | `0` |  |
| keda.logging.operator.format | string | `"json"` |  |
| keda.logging.operator.level | string | `"info"` |  |
| keda.prometheus.metricServer.enabled | bool | `true` |  |
| keda.prometheus.metricServer.podMonitor.additionalLabels."prometheus.io/operator" | string | `"portefaix"` |  |
| keda.prometheus.metricServer.podMonitor.enabled | bool | `true` |  |
| keda.prometheus.operator.enabled | bool | `true` |  |
| keda.prometheus.operator.podMonitor.additionalLabels."prometheus.io/operator" | string | `"portefaix"` |  |
| keda.prometheus.operator.podMonitor.enabled | bool | `true` |  |
| keda.prometheus.operator.prometheusRules.additionalLabels."prometheus.io/operator" | string | `"portefaix"` |  |
| keda.prometheus.operator.prometheusRules.alerts[0].alert | string | `"KedaScalerErrors"` |  |
| keda.prometheus.operator.prometheusRules.alerts[0].annotations.description | string | `"Keda scaledObject {{ $labels.scaledObject }} is experiencing errors with {{ $labels.scaler }} scaler"` |  |
| keda.prometheus.operator.prometheusRules.alerts[0].annotations.summary | string | `"Keda Scaler {{ $labels.scaler }} Errors"` |  |
| keda.prometheus.operator.prometheusRules.alerts[0].expr | string | `"sum by ( scaledObject , scaler) (rate(keda_metrics_adapter_scaler_errors[2m]))  > 0"` |  |
| keda.prometheus.operator.prometheusRules.alerts[0].for | string | `"2m"` |  |
| keda.prometheus.operator.prometheusRules.alerts[0].labels.severity | string | `"warning"` |  |
| keda.prometheus.operator.prometheusRules.enabled | bool | `true` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
