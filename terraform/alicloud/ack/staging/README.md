## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | 1.148.0 |

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
| <a name="input_cluster_addons"></a> [cluster\_addons](#input\_cluster\_addons) | Addon components in kubernetes cluster | <pre>list(object({<br>    name   = string<br>    config = string<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name prefix used to create managed kubernetes cluster. | `string` | `"terraform-alicloud-managed-kubernetes"` | no |
| <a name="input_cpu_core_count"></a> [cpu\_core\_count](#input\_cpu\_core\_count) | CPU core count is used to fetch instance types. | `number` | `1` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Desired Kubernetes version | `string` | n/a | yes |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Memory size used to fetch instance types. | `number` | `2` | no |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | The kubernetes pod cidr block. It cannot be equals to vpc's or vswitch's and cannot be in them. If vpc's cidr block is `172.16.XX.XX/XX`, it had better to `192.168.XX.XX/XX` or `10.XX.XX.XX/XX`. | `string` | `"172.20.0.0/16"` | no |
| <a name="input_pod_vswitch_name"></a> [pod\_vswitch\_name](#input\_pod\_vswitch\_name) | The vswitch name prefix used. | `string` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | The kubernetes service cidr block. It cannot be equals to vpc's or vswitch's or pod's and cannot be in them. Its setting rule is same as `k8s_pod_cidr`. | `string` | `"172.21.0.0/20"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC where to create nat gateway. | `string` | n/a | yes |
| <a name="input_vswitch_name"></a> [vswitch\_name](#input\_vswitch\_name) | The vswitch name prefix used. | `string` | n/a | yes |
| <a name="input_worker_disk_category"></a> [worker\_disk\_category](#input\_worker\_disk\_category) | The system disk category used to launch one or more worker nodes. | `string` | `"cloud_efficiency"` | no |
| <a name="input_worker_disk_size"></a> [worker\_disk\_size](#input\_worker\_disk\_size) | The system disk size used to launch one or more worker nodes. | `number` | `40` | no |
| <a name="input_worker_instance_types"></a> [worker\_instance\_types](#input\_worker\_instance\_types) | The ecs instance type used to launch worker nodes. If not set, data source `alicloud_instance_types` will return one based on `cpu_core_count` and `memory_size`. | `list(string)` | <pre>[<br>  "ecs.n4.xlarge"<br>]</pre> | no |
| <a name="input_worker_number"></a> [worker\_number](#input\_worker\_number) | The number of kubernetes cluster work nodes. | `number` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
