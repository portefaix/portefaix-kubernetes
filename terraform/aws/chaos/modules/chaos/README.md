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

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa_litmuschaos"></a> [irsa\_litmuschaos](#module\_irsa\_litmuschaos) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 5.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.fis](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.litmus](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.fis](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/iam_role) | resource |
| [aws_iam_role.fis_assume_role](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/iam_role) | resource |
| [aws_iam_policy_document.fis](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.fis_assume_role](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.litmus](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for AWS resources | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
