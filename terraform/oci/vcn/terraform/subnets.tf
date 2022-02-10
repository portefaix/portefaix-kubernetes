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

# resource "oci_core_subnet" "control_plane" {
#   cidr_block                 = var.control_plane_cidr
#   compartment_id             = var.compartment_ocid
#   display_name               = local.control_plane_subnet_name
#   dns_label                  = "cp"
#   prohibit_public_ip_on_vnic = true
#   vcn_id                     = module.vcn.vcn_id
#   route_table_id             = module.vcn.ig_route_id
#   security_list_ids          = [oci_core_security_list.control_plane.id]
# }

# resource "oci_core_subnet" "workers" {
#   cidr_block                 = var.workers_cidr
#   compartment_id             = var.compartment_ocid
#   display_name               = local.workers_subnet_name
#   dns_label                  = "workers"
#   prohibit_public_ip_on_vnic = true
#   vcn_id                     = module.vcn.vcn_id
#   route_table_id             = module.vcn.ig_route_id
# }

# resource "oci_core_subnet" "int_lb" {
#   cidr_block                 = var.int_lb_cidr
#   compartment_id             = var.compartment_ocid
#   display_name               = local.int_lb_subnet_name
#   dns_label                  = "intlb"
#   prohibit_public_ip_on_vnic = true
#   vcn_id                     = module.vcn.vcn_id
#   route_table_id             = module.vcn.nat_route_id
# }

# resource "oci_core_subnet" "pub_lb" {
#   cidr_block                 = var.pub_lb_cidr
#   compartment_id             = var.compartment_ocid
#   display_name               = local.pub_lb_subnet_name
#   dns_label                  = "publb"
#   prohibit_public_ip_on_vnic = false
#   vcn_id                     = module.vcn.vcn_id
#   route_table_id             = module.vcn.ig_route_id
#   # security_list_ids          = [oci_core_security_list.pub_lb_seclist[0].id]
# }
