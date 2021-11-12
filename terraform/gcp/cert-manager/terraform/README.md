## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.0 |
| google | >= 3.55.0 |

## Providers

No provider.

## Modules

| Name | Source | Version |
|------|--------|---------|
| cert_manager | nlamirault/cert-manager/google | 0.3.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| namespace | The Kubernetes namespace | `string` | n/a | yes |
| project | The project in which the resource belongs | `string` | n/a | yes |
| region | The location linked to the project | `string` | n/a | yes |
| service\_account | The Kubernetes service account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cert\_manager\_service\_account | Service Account for Cert Manager |
