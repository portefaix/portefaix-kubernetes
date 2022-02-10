## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 4.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 4.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_artifact_registry_repository.core](https://registry.terraform.io/providers/hashicorp/google-beta/4.9.0/docs/resources/google_artifact_registry_repository) | resource |
| [google-beta_google_artifact_registry_repository_iam_member.readers](https://registry.terraform.io/providers/hashicorp/google-beta/4.9.0/docs/resources/google_artifact_registry_repository_iam_member) | resource |
| [google-beta_google_artifact_registry_repository_iam_member.writers](https://registry.terraform.io/providers/hashicorp/google-beta/4.9.0/docs/resources/google_artifact_registry_repository_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_labels"></a> [labels](#input\_labels) | Map of maps containing node labels by node-pool name | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | The project in which the resource belongs | `string` | n/a | yes |
| <a name="input_readers"></a> [readers](#input\_readers) | Readonly service accounts, users, ... | `set(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The location linked to the project | `string` | n/a | yes |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | The name of the router in which this NAT will be configured | <pre>map(object({<br>    location = string<br>    format   = string<br>  }))</pre> | n/a | yes |
| <a name="input_writers"></a> [writers](#input\_writers) | ReadWrite service accounts, users, ... | `set(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
