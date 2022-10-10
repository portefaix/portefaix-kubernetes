## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.17.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudtrail"></a> [cloudtrail](#module\_cloudtrail) | ../modules/cloudtrail | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Bucket name of Cloudtrail logs | `string` | n/a | yes |
| <a name="input_cloudtrail_name"></a> [cloudtrail\_name](#input\_cloudtrail\_name) | Name of the Cloudtrail | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags for the AWS provider | `map(string)` | <pre>{<br>  "Made-By": "Terraform",<br>  "Portefaix-Version": "v0.41.0",<br>  "Project": "Portefaix"<br>}</pre> | no |
| <a name="input_logging_account_id"></a> [logging\_account\_id](#input\_logging\_account\_id) | ID of the Logging AWS Account | `string` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Name of the AWS Organization | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_retention_period"></a> [retention\_period](#input\_retention\_period) | Retention period of the Kinesis stream (in days) | `number` | `7` | no |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | Number of shards to use in the Kinesis stream | `number` | `4` | no |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | Kinesis stream name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for AWS resources | `map(string)` | <pre>{<br>  "Service": "Cloudtrail"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
