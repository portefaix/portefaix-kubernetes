## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.69.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.69.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_adot"></a> [adot](#module\_adot) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.7.0 |
| <a name="module_alb_controller_role"></a> [alb\_controller\_role](#module\_alb\_controller\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.7.0 |
| <a name="module_appmesh_controller_role"></a> [appmesh\_controller\_role](#module\_appmesh\_controller\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.7.0 |
| <a name="module_cluster_autoscaler_role"></a> [cluster\_autoscaler\_role](#module\_cluster\_autoscaler\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.7.0 |
| <a name="module_ebs_controller_role"></a> [ebs\_controller\_role](#module\_ebs\_controller\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.7.0 |
| <a name="module_efs_controller_role"></a> [efs\_controller\_role](#module\_efs\_controller\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.7.0 |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 17.24.0 |
| <a name="module_fsx_controller_role"></a> [fsx\_controller\_role](#module\_fsx\_controller\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.7.0 |
| <a name="module_secret_store_controller_role"></a> [secret\_store\_controller\_role](#module\_secret\_store\_controller\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.7.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.coredns](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/eks_addon) | resource |
| [aws_eks_addon.kube_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/eks_addon) | resource |
| [aws_eks_addon.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/eks_addon) | resource |
| [aws_iam_policy.adot](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.alb_controller](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ebs_csi_driver_controller](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.efs_csi_driver_controller](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.fsx_csi_driver_controller](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.secret_store_csi_driver_controller](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/data-sources/iam_policy_document) | data source |
| [aws_subnet_ids.private](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addon_coredns_version"></a> [addon\_coredns\_version](#input\_addon\_coredns\_version) | Version of CoreDNS to install | `string` | n/a | yes |
| <a name="input_addon_kube_proxy_version"></a> [addon\_kube\_proxy\_version](#input\_addon\_kube\_proxy\_version) | Version of kube proxy to install | `string` | n/a | yes |
| <a name="input_addon_vpc_cni_version"></a> [addon\_vpc\_cni\_version](#input\_addon\_vpc\_cni\_version) | Version of the VPC CNI to install | `string` | n/a | yes |
| <a name="input_adot_collector_name"></a> [adot\_collector\_name](#input\_adot\_collector\_name) | The name of the ADOT Collector IAM role | `string` | `"adot-collector"` | no |
| <a name="input_adot_collector_role_policy_name"></a> [adot\_collector\_role\_policy\_name](#input\_adot\_collector\_role\_policy\_name) | The name of the ADOT Collector IAM policy | `string` | `"AWSAMPIngestIAMPolicy"` | no |
| <a name="input_adot_namespace"></a> [adot\_namespace](#input\_adot\_namespace) | The K8s namespace which contains the ADOT collector | `string` | `"aws-observability"` | no |
| <a name="input_adot_sa_name"></a> [adot\_sa\_name](#input\_adot\_sa\_name) | ADOT Collector name | `string` | `"adot-collector"` | no |
| <a name="input_adot_tags"></a> [adot\_tags](#input\_adot\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |
| <a name="input_alb_controller_namespace"></a> [alb\_controller\_namespace](#input\_alb\_controller\_namespace) | The K8s namespace for ALB Controller resources | `string` | `"kube-system"` | no |
| <a name="input_alb_controller_role_name"></a> [alb\_controller\_role\_name](#input\_alb\_controller\_role\_name) | The name of the EBS CSI driver IAM role | `string` | `"aws-load-balancer-controller"` | no |
| <a name="input_alb_controller_role_policy_name"></a> [alb\_controller\_role\_policy\_name](#input\_alb\_controller\_role\_policy\_name) | The prefix of the EBS CSI driver IAM policy | `string` | `"AWSLoadBalancerControllerIAMPolicy"` | no |
| <a name="input_alb_controller_sa_name"></a> [alb\_controller\_sa\_name](#input\_alb\_controller\_sa\_name) | Controller name | `string` | `"aws-load-balancer-controller"` | no |
| <a name="input_alb_controller_tags"></a> [alb\_controller\_tags](#input\_alb\_controller\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |
| <a name="input_appmesh_controller_role_name"></a> [appmesh\_controller\_role\_name](#input\_appmesh\_controller\_role\_name) | The name of the AppMesh Controller IAM role | `string` | `"appmesh-controller"` | no |
| <a name="input_appmesh_namespace"></a> [appmesh\_namespace](#input\_appmesh\_namespace) | The K8s namespace for ALB Controller resources | `string` | `"appmesh-system"` | no |
| <a name="input_appmesh_sa_name"></a> [appmesh\_sa\_name](#input\_appmesh\_sa\_name) | Controller name | `string` | `"appmesh-controller"` | no |
| <a name="input_appmesh_tags"></a> [appmesh\_tags](#input\_appmesh\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |
| <a name="input_cluster_autoscaler_namespace"></a> [cluster\_autoscaler\_namespace](#input\_cluster\_autoscaler\_namespace) | The K8s namespace for  resources | `string` | `"kube-system"` | no |
| <a name="input_cluster_autoscaler_role_name"></a> [cluster\_autoscaler\_role\_name](#input\_cluster\_autoscaler\_role\_name) | The name of the AppMesh Controller IAM role | `string` | `"cluster-autoscaler-controller"` | no |
| <a name="input_cluster_autoscaler_role_policy_name"></a> [cluster\_autoscaler\_role\_policy\_name](#input\_cluster\_autoscaler\_role\_policy\_name) | The name of the AppMesh Controller IAM policy | `string` | `"AWSClusterAutoscalerIAMPolicy"` | no |
| <a name="input_cluster_autoscaler_sa_name"></a> [cluster\_autoscaler\_sa\_name](#input\_cluster\_autoscaler\_sa\_name) | Controller name | `string` | `"cluster-autoscaler-controller"` | no |
| <a name="input_cluster_autoscaler_tags"></a> [cluster\_autoscaler\_tags](#input\_cluster\_autoscaler\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_cluster_tags"></a> [cluster\_tags](#input\_cluster\_tags) | A map of tags to add to just the eks resource. | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | The EKS Kubernetes version | `string` | n/a | yes |
| <a name="input_ebs_csi_controller_namespace"></a> [ebs\_csi\_controller\_namespace](#input\_ebs\_csi\_controller\_namespace) | The K8s namespace for all EBS CSI driver resources | `string` | `"kube-system"` | no |
| <a name="input_ebs_csi_controller_role_name"></a> [ebs\_csi\_controller\_role\_name](#input\_ebs\_csi\_controller\_role\_name) | The name of the EBS CSI driver IAM role | `string` | `"ebs-csi-driver-controller"` | no |
| <a name="input_ebs_csi_controller_role_policy_name"></a> [ebs\_csi\_controller\_role\_policy\_name](#input\_ebs\_csi\_controller\_role\_policy\_name) | The prefix of the EBS CSI driver IAM policy | `string` | `"AmazonEKS_EBS_CSI_Driver_Policy"` | no |
| <a name="input_ebs_csi_controller_sa_name"></a> [ebs\_csi\_controller\_sa\_name](#input\_ebs\_csi\_controller\_sa\_name) | Controller name | `string` | `"ebs-csi-controller"` | no |
| <a name="input_ebs_csi_driver_tags"></a> [ebs\_csi\_driver\_tags](#input\_ebs\_csi\_driver\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |
| <a name="input_efs_csi_controller_namespace"></a> [efs\_csi\_controller\_namespace](#input\_efs\_csi\_controller\_namespace) | The K8s namespace for all EFS CSI driver resources | `string` | `"kube-system"` | no |
| <a name="input_efs_csi_controller_role_name"></a> [efs\_csi\_controller\_role\_name](#input\_efs\_csi\_controller\_role\_name) | The name of the EFS CSI driver IAM role | `string` | `"efs-csi-driver-controller"` | no |
| <a name="input_efs_csi_controller_role_policy_name"></a> [efs\_csi\_controller\_role\_policy\_name](#input\_efs\_csi\_controller\_role\_policy\_name) | The prefix of the EFS CSI driver IAM policy | `string` | `"AmazonEKS_EFS_CSI_Driver_Policy"` | no |
| <a name="input_efs_csi_controller_sa_name"></a> [efs\_csi\_controller\_sa\_name](#input\_efs\_csi\_controller\_sa\_name) | Controller name | `string` | `"efs-csi-controller"` | no |
| <a name="input_efs_csi_driver_tags"></a> [efs\_csi\_driver\_tags](#input\_efs\_csi\_driver\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |
| <a name="input_enabled_logs"></a> [enabled\_logs](#input\_enabled\_logs) | A list of the desired control plane logging to enable | `list(any)` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| <a name="input_fsx_csi_controller_namespace"></a> [fsx\_csi\_controller\_namespace](#input\_fsx\_csi\_controller\_namespace) | The K8s namespace for all FSX CSI driver resources | `string` | `"kube-system"` | no |
| <a name="input_fsx_csi_controller_role_name"></a> [fsx\_csi\_controller\_role\_name](#input\_fsx\_csi\_controller\_role\_name) | The name of the FSX CSI driver IAM role | `string` | `"fsx-csi-driver-controller"` | no |
| <a name="input_fsx_csi_controller_role_policy_name"></a> [fsx\_csi\_controller\_role\_policy\_name](#input\_fsx\_csi\_controller\_role\_policy\_name) | The prefix of the FSX CSI driver IAM policy | `string` | `"AmazonEKS_FSX_CSI_Driver_Policy"` | no |
| <a name="input_fsx_csi_controller_sa_name"></a> [fsx\_csi\_controller\_sa\_name](#input\_fsx\_csi\_controller\_sa\_name) | Controller name | `string` | `"fsx-csi-controller"` | no |
| <a name="input_fsx_csi_driver_tags"></a> [fsx\_csi\_driver\_tags](#input\_fsx\_csi\_driver\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |
| <a name="input_log_retention"></a> [log\_retention](#input\_log\_retention) | Days of log retention in cloudwatch | `number` | `7` | no |
| <a name="input_map_roles"></a> [map\_roles](#input\_map\_roles) | Additional IAM roles to add to the aws-auth configmap. | <pre>list(object({<br>    rolearn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | Map of map of node groups to create. See `node_groups` module's documentation for more details | `any` | n/a | yes |
| <a name="input_node_groups_defaults"></a> [node\_groups\_defaults](#input\_node\_groups\_defaults) | Map of values to be applied to all node groups. See `node_groups` module's documentation for more details | `any` | n/a | yes |
| <a name="input_secret_store_csi_controller_role_name"></a> [secret\_store\_csi\_controller\_role\_name](#input\_secret\_store\_csi\_controller\_role\_name) | The name of the Secret Store CSI driver IAM role | `string` | `"secret-store-csi-driver-controller"` | no |
| <a name="input_secret_store_csi_controller_role_policy_name"></a> [secret\_store\_csi\_controller\_role\_policy\_name](#input\_secret\_store\_csi\_controller\_role\_policy\_name) | The prefix of the Secret Store CSI driver IAM policy | `string` | `"AmazonEKS_SecretStore_CSI_Driver_Policy"` | no |
| <a name="input_secret_store_csi_driver_tags"></a> [secret\_store\_csi\_driver\_tags](#input\_secret\_store\_csi\_driver\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |
| <a name="input_secrets_data"></a> [secrets\_data](#input\_secrets\_data) | Secret Store CSI Driver data | <pre>list(object({<br>    name      = string<br>    prefix    = string<br>    namespace = string<br>    sa_name   = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. Tags added to launch configuration or templates override these values for ASG Tags only. | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | ID of the VPC | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
