## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.68.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ack"></a> [ack](#module\_ack) | ../modules/ack | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ack_eks_name"></a> [ack\_eks\_name](#input\_ack\_eks\_name) | ACK EKS controller name | `string` | `"eks"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags for the AWS provider | `map(string)` | <pre>{<br>  "Made-By": "terraform",<br>  "Project": "portefaix"<br>}</pre> | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The K8s namespace for ALB Controller resources | `string` | `"ack-system"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_services"></a> [services](#input\_services) | ACK services deployed | <pre>list(object({<br>    name       = string<br>    policy_arn = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "apigatewayv2",<br>    "policy_arn": "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"<br>  },<br>  {<br>    "name": "applicationautoscaling",<br>    "policy_arn": "arn:aws:iam::aws:policy/PowerUserAccess"<br>  },<br>  {<br>    "name": "dynamodb",<br>    "policy_arn": "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"<br>  },<br>  {<br>    "name": "ec2",<br>    "policy_arn": "arn:aws:iam::aws:policy/AmazonEC2FullAccess"<br>  },<br>  {<br>    "name": "ecr",<br>    "policy_arn": "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"<br>  },<br>  {<br>    "name": "apigatewayv2",<br>    "policy_arn": "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"<br>  },<br>  {<br>    "name": "elasticache",<br>    "policy_arn": "arn:aws:iam::aws:policy/AmazonElastiCacheFullAccess"<br>  },<br>  {<br>    "name": "kms",<br>    "policy_arn": "arn:aws:iam::aws:policy/AWSKeyManagementServicePowerUser"<br>  },<br>  {<br>    "name": "lambda",<br>    "policy_arn": "arn:aws:iam::aws:policy/AWSLambda_FullAccess"<br>  },<br>  {<br>    "name": "mq",<br>    "policy_arn": "arn:aws:iam::aws:policy/AmazonMQApiFullAccess"<br>  },<br>  {<br>    "name": "opensearchservice",<br>    "policy_arn": "arn:aws:iam::aws:policy/AmazonOpenSearchServiceFullAccess"<br>  },<br>  {<br>    "name": "rds",<br>    "policy_arn": "arn:aws:iam::aws:policy/AmazonRDSFullAccess"<br>  },<br>  {<br>    "name": "s3",<br>    "policy_arn": "arn:aws:iam::aws:policy/AmazonS3FullAccess"<br>  },<br>  {<br>    "name": "sagemaker",<br>    "policy_arn": "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"<br>  },<br>  {<br>    "name": "sfn",<br>    "policy_arn": "arn:aws:iam::aws:policy/AWSStepFunctionsFullAccess"<br>  },<br>  {<br>    "name": "sns",<br>    "policy_arn": "arn:aws:iam::aws:policy/AmazonSNSFullAccess"<br>  }<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
