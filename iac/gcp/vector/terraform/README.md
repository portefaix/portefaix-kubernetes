## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.0 |
| google | 3.72.0 |

## Providers

No provider.

## Modules

| Name | Source | Version |
|------|--------|---------|
| vector | nlamirault/vector/google | 0.3.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_labels | Map of labels to apply to the bucket | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| bucket\_location | The bucket location | `string` | n/a | yes |
| bucket\_storage\_class | Bucket storage class. | `string` | `"MULTI_REGIONAL"` | no |
| keyring\_location | The KMS keyring location | `string` | n/a | yes |
| namespace | The Kubernetes namespace | `string` | n/a | yes |
| project | The project in which the resource belongs | `string` | n/a | yes |
| region | The location linked to the project | `string` | n/a | yes |
| service\_account | The Kubernetes service account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| vector\_service\_account | Service Account for Vector |
