# aws-load-balancer-controller

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.3.2](https://img.shields.io/badge/AppVersion-1.3.2-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://aws.github.io/eks-charts | aws-load-balancer-controller | 1.4.7 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| aws-load-balancer-controller.enableCertManager | bool | `true` |  |
| aws-load-balancer-controller.serviceAccount.name | string | `"aws-load-balancer-controller"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)