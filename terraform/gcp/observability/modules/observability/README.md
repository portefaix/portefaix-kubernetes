## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_grafana"></a> [grafana](#module\_grafana) | nlamirault/observability/google//modules/grafana | 5.3.0 |
| <a name="module_loki"></a> [loki](#module\_loki) | nlamirault/observability/google//modules/loki | 5.3.0 |
| <a name="module_prometheus"></a> [prometheus](#module\_prometheus) | nlamirault/observability/google//modules/prometheus | 5.3.0 |
| <a name="module_tempo"></a> [tempo](#module\_tempo) | nlamirault/observability/google//modules/tempo | 5.3.0 |
| <a name="module_thanos"></a> [thanos](#module\_thanos) | nlamirault/observability/google//modules/thanos | 5.3.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_grafana_namespace"></a> [grafana\_namespace](#input\_grafana\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_grafana_service_account"></a> [grafana\_service\_account](#input\_grafana\_service\_account) | The Kubernetes service account | `string` | n/a | yes |
| <a name="input_loki_bucket_labels"></a> [loki\_bucket\_labels](#input\_loki\_bucket\_labels) | Map of labels to apply to the bucket | `map(string)` | n/a | yes |
| <a name="input_loki_bucket_location"></a> [loki\_bucket\_location](#input\_loki\_bucket\_location) | The bucket location | `string` | n/a | yes |
| <a name="input_loki_bucket_storage_class"></a> [loki\_bucket\_storage\_class](#input\_loki\_bucket\_storage\_class) | Bucket storage class. | `string` | `"MULTI_REGIONAL"` | no |
| <a name="input_loki_enable_kms"></a> [loki\_enable\_kms](#input\_loki\_enable\_kms) | Enable custom KMS key | `bool` | n/a | yes |
| <a name="input_loki_keyring_location"></a> [loki\_keyring\_location](#input\_loki\_keyring\_location) | The KMS keyring location | `string` | n/a | yes |
| <a name="input_loki_keys"></a> [loki\_keys](#input\_loki\_keys) | Key names. | `list(string)` | `[]` | no |
| <a name="input_loki_kms_labels"></a> [loki\_kms\_labels](#input\_loki\_kms\_labels) | Map of labels to apply to the KMS resources | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| <a name="input_loki_namespace"></a> [loki\_namespace](#input\_loki\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_loki_service_account"></a> [loki\_service\_account](#input\_loki\_service\_account) | The Kubernetes service account | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project in which the resource belongs | `string` | n/a | yes |
| <a name="input_prometheus_namespace"></a> [prometheus\_namespace](#input\_prometheus\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_prometheus_service_account"></a> [prometheus\_service\_account](#input\_prometheus\_service\_account) | The Kubernetes service account | `string` | n/a | yes |
| <a name="input_tempo_bucket_labels"></a> [tempo\_bucket\_labels](#input\_tempo\_bucket\_labels) | Map of labels to apply to the bucket | `map(string)` | n/a | yes |
| <a name="input_tempo_bucket_location"></a> [tempo\_bucket\_location](#input\_tempo\_bucket\_location) | The bucket location | `string` | n/a | yes |
| <a name="input_tempo_bucket_storage_class"></a> [tempo\_bucket\_storage\_class](#input\_tempo\_bucket\_storage\_class) | Bucket storage class. | `string` | `"MULTI_REGIONAL"` | no |
| <a name="input_tempo_enable_kms"></a> [tempo\_enable\_kms](#input\_tempo\_enable\_kms) | Enable custom KMS key | `bool` | n/a | yes |
| <a name="input_tempo_keyring_location"></a> [tempo\_keyring\_location](#input\_tempo\_keyring\_location) | The KMS keyring location | `string` | n/a | yes |
| <a name="input_tempo_keys"></a> [tempo\_keys](#input\_tempo\_keys) | Key names. | `list(string)` | `[]` | no |
| <a name="input_tempo_kms_labels"></a> [tempo\_kms\_labels](#input\_tempo\_kms\_labels) | Map of labels to apply to the KMS resources | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| <a name="input_tempo_namespace"></a> [tempo\_namespace](#input\_tempo\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_tempo_service_account"></a> [tempo\_service\_account](#input\_tempo\_service\_account) | The Kubernetes service account | `string` | n/a | yes |
| <a name="input_thanos_bucket_labels"></a> [thanos\_bucket\_labels](#input\_thanos\_bucket\_labels) | Map of labels to apply to the bucket | `map(string)` | n/a | yes |
| <a name="input_thanos_bucket_location"></a> [thanos\_bucket\_location](#input\_thanos\_bucket\_location) | The bucket location | `string` | n/a | yes |
| <a name="input_thanos_bucket_storage_class"></a> [thanos\_bucket\_storage\_class](#input\_thanos\_bucket\_storage\_class) | Bucket storage class. | `string` | `"MULTI_REGIONAL"` | no |
| <a name="input_thanos_enable_kms"></a> [thanos\_enable\_kms](#input\_thanos\_enable\_kms) | Enable custom KMS key | `bool` | n/a | yes |
| <a name="input_thanos_keyring_location"></a> [thanos\_keyring\_location](#input\_thanos\_keyring\_location) | The KMS keyring location | `string` | n/a | yes |
| <a name="input_thanos_keys"></a> [thanos\_keys](#input\_thanos\_keys) | Key names. | `list(string)` | `[]` | no |
| <a name="input_thanos_kms_labels"></a> [thanos\_kms\_labels](#input\_thanos\_kms\_labels) | Map of labels to apply to the KMS resources | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| <a name="input_thanos_namespace"></a> [thanos\_namespace](#input\_thanos\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_thanos_service_account"></a> [thanos\_service\_account](#input\_thanos\_service\_account) | The Kubernetes service account | `list(string)` | n/a | yes |
| <a name="input_thanos_sidecar_service_account"></a> [thanos\_sidecar\_service\_account](#input\_thanos\_sidecar\_service\_account) | The Google service account ID of Prometheus | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_grafana_service_account"></a> [grafana\_service\_account](#output\_grafana\_service\_account) | Service Account for Grafana |
| <a name="output_loki_bucket"></a> [loki\_bucket](#output\_loki\_bucket) | Loki bucket resource |
| <a name="output_loki_service_account"></a> [loki\_service\_account](#output\_loki\_service\_account) | Service Account for Loki |
| <a name="output_prometheus_service_account"></a> [prometheus\_service\_account](#output\_prometheus\_service\_account) | Service Account for Prometheus |
| <a name="output_tempo_bucket"></a> [tempo\_bucket](#output\_tempo\_bucket) | Tempo bucket resource |
| <a name="output_tempo_service_account"></a> [tempo\_service\_account](#output\_tempo\_service\_account) | Service Account for Tempo |
| <a name="output_thanos_bucket"></a> [thanos\_bucket](#output\_thanos\_bucket) | Thanos bucket resource |
| <a name="output_thanos_service_accounts"></a> [thanos\_service\_accounts](#output\_thanos\_service\_accounts) | Service Account for Thanos |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
