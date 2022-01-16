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
| <a name="module_pubsub"></a> [pubsub](#module\_pubsub) | terraform-google-modules/pubsub/google | 3.1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project"></a> [project](#input\_project) | The project in which the resource belongs | `string` | n/a | yes |
| <a name="input_subscription_labels"></a> [subscription\_labels](#input\_subscription\_labels) | A map of labels to assign to every Pub/Sub subscription | `map(string)` | n/a | yes |
| <a name="input_topic"></a> [topic](#input\_topic) | The Pub/Sub topic name | `string` | n/a | yes |
| <a name="input_topic_labels"></a> [topic\_labels](#input\_topic\_labels) | A map of labels to assign to the Pub/Sub topic | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
