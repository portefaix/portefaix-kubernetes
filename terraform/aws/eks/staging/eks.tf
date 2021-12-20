# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#tfsec:ignore:AWS066 tfsec:ignore:AWS068 tfsec:ignore:AWS069
module "eks" {
  source = "../modules/eks"

  vpc_name = var.vpc_name

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  tags         = var.tags
  cluster_tags = var.cluster_tags

  node_groups_defaults = var.node_groups_defaults
  node_groups          = var.node_groups
  map_roles            = var.map_roles

  addon_vpc_cni_version    = var.addon_vpc_cni_version
  addon_coredns_version    = var.addon_coredns_version
  addon_kube_proxy_version = var.addon_kube_proxy_version

  enabled_logs  = var.enabled_logs
  log_retention = var.log_retention

  ebs_csi_driver_tags          = var.ebs_csi_driver_tags
  ebs_csi_controller_sa_name   = var.ebs_csi_controller_sa_name
  ebs_csi_controller_namespace = var.ebs_csi_controller_namespace

  efs_csi_driver_tags          = var.efs_csi_driver_tags
  efs_csi_controller_sa_name   = var.efs_csi_controller_sa_name
  efs_csi_controller_namespace = var.efs_csi_controller_namespace

  fsx_csi_driver_tags          = var.fsx_csi_driver_tags
  fsx_csi_controller_sa_name   = var.fsx_csi_controller_sa_name
  fsx_csi_controller_namespace = var.fsx_csi_controller_namespace

  secret_store_csi_driver_tags = var.secret_store_csi_driver_tags
  secrets_data                 = var.secrets_data

  alb_controller_tags      = var.alb_controller_tags
  alb_controller_sa_name   = var.alb_controller_sa_name
  alb_controller_namespace = var.alb_controller_namespace

  appmesh_tags      = var.appmesh_tags
  appmesh_sa_name   = var.appmesh_sa_name
  appmesh_namespace = var.appmesh_namespace

  cluster_autoscaler_tags      = var.cluster_autoscaler_tags
  cluster_autoscaler_sa_name   = var.cluster_autoscaler_sa_name
  cluster_autoscaler_namespace = var.cluster_autoscaler_namespace

  adot_tags      = var.adot_tags
  adot_sa_name   = var.adot_sa_name
  adot_namespace = var.adot_namespace
}
