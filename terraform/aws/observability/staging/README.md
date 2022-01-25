## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.73.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_observability"></a> [observability](#module\_observability) | ../modules/observability | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amp_alias"></a> [amp\_alias](#input\_amp\_alias) | AWS Managed Prometheus workspace name | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags for the AWS provider | `map(string)` | <pre>{<br>  "Made-By": "terraform",<br>  "Project": "portefaix"<br>}</pre> | no |
| <a name="input_grafana_namespace"></a> [grafana\_namespace](#input\_grafana\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_grafana_service_account"></a> [grafana\_service\_account](#input\_grafana\_service\_account) | The Kubernetes service account | `string` | n/a | yes |
| <a name="input_grafana_tags"></a> [grafana\_tags](#input\_grafana\_tags) | Tags for Loki | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |
| <a name="input_loki_enable_kms"></a> [loki\_enable\_kms](#input\_loki\_enable\_kms) | Enable custom KMS key | `bool` | n/a | yes |
| <a name="input_loki_namespace"></a> [loki\_namespace](#input\_loki\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_loki_service_account"></a> [loki\_service\_account](#input\_loki\_service\_account) | The Kubernetes service account | `string` | n/a | yes |
| <a name="input_loki_tags"></a> [loki\_tags](#input\_loki\_tags) | Tags for Loki | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |
| <a name="input_prometheus_enable_kms"></a> [prometheus\_enable\_kms](#input\_prometheus\_enable\_kms) | Enable custom KMS key | `bool` | n/a | yes |
| <a name="input_prometheus_namespace"></a> [prometheus\_namespace](#input\_prometheus\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_prometheus_service_account"></a> [prometheus\_service\_account](#input\_prometheus\_service\_account) | The Kubernetes service account | `string` | n/a | yes |
| <a name="input_prometheus_tags"></a> [prometheus\_tags](#input\_prometheus\_tags) | Tags for Loki | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_tempo_enable_kms"></a> [tempo\_enable\_kms](#input\_tempo\_enable\_kms) | Enable custom KMS key | `bool` | n/a | yes |
| <a name="input_tempo_namespace"></a> [tempo\_namespace](#input\_tempo\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_tempo_service_account"></a> [tempo\_service\_account](#input\_tempo\_service\_account) | The Kubernetes service account | `string` | n/a | yes |
| <a name="input_tempo_tags"></a> [tempo\_tags](#input\_tempo\_tags) | Tags for Loki | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |
| <a name="input_thanos_enable_kms"></a> [thanos\_enable\_kms](#input\_thanos\_enable\_kms) | Enable custom KMS key | `bool` | n/a | yes |
| <a name="input_thanos_namespace"></a> [thanos\_namespace](#input\_thanos\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_thanos_service_accounts"></a> [thanos\_service\_accounts](#input\_thanos\_service\_accounts) | The Kubernetes service account | `list(string)` | n/a | yes |
| <a name="input_thanos_tags"></a> [thanos\_tags](#input\_thanos\_tags) | Tags for Thanos | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
