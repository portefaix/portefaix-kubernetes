# Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.17.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.17.0 |
| <a name="provider_aws.logging"></a> [aws.logging](#provider\_aws.logging) | 4.17.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket_cloudtrail"></a> [bucket\_cloudtrail](#module\_bucket\_cloudtrail) | terraform-aws-modules/s3-bucket/aws | 3.2.3 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.this](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/cloudtrail) | resource |
| [aws_kinesis_stream.cloudtrail_logs](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/kinesis_stream) | resource |
| [aws_s3_bucket_policy.cloudtrail_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/s3_bucket_policy) | resource |
| [aws_sns_topic.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/sns_topic_policy) | resource |
| [aws_iam_policy_document.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudtrail_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudtrail_bucket_name"></a> [cloudtrail\_bucket\_name](#input\_cloudtrail\_bucket\_name) | Bucket name of Cloudtrail logs | `string` | n/a | yes |
| <a name="input_cloudtrail_name"></a> [cloudtrail\_name](#input\_cloudtrail\_name) | Name of the Cloudtrail | `string` | n/a | yes |
| <a name="input_cloudtrail_topic_name"></a> [cloudtrail\_topic\_name](#input\_cloudtrail\_topic\_name) | Name of the SNS topic where information about newly shipped CloudTrail log files are sent | `string` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Name of the AWS Organization | `string` | n/a | yes |
| <a name="input_retention_period"></a> [retention\_period](#input\_retention\_period) | Retention period of the Kinesis stream (in days) | `number` | `7` | no |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | Number of shards to use in the Kinesis stream | `number` | `4` | no |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | Kinesis stream name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for AWS resources | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
