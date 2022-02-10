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

module "oke" {
  # source  = "oracle-terraform-modules/oke/oci"
  # version = "4.1.3"
  source = "/home/nicolas/Projects/Forks/terraform-oci-oke-oracle-modules"

  compartment_id = var.compartment_ocid
  tenancy_id     = var.tenancy_ocid
  region         = var.region
  home_region    = var.region

  label_prefix = var.label_prefix

  create_vcn                   = false
  vcn_display_name             = var.vcn_display_name
  ig_route_table_display_name  = var.ig_route_table_display_name
  nat_route_table_display_name = var.nat_route_table_display_name

  create_bastion_host = false

  create_operator = false

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version

  control_plane_type = "private"
  worker_type        = "private"
  load_balancers     = "both"

  pods_cidr     = var.pods_cidr
  services_cidr = var.services_cidr

  node_pool_name_prefix = var.node_pool_name_prefix
  node_pool_os          = var.node_pool_os
  node_pool_os_version  = var.node_pool_os_version
  node_pools            = var.node_pools

  freeform_tags = var.freeform_tags

  providers = {
    oci.home = oci.home
  }
}
