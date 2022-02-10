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

# resource "oci_core_security_list" "control_plane" {
#   compartment_id = var.compartment_ocid
#   display_name   = local.controler_plane_seclist_name

#   vcn_id = module.vcn.vcn_id

#   dynamic "egress_security_rules" {
#     iterator = cp_egress_iterator
#     for_each = local.cp_egress_seclist

#     content {

#       description      = cp_egress_iterator.value["description"]
#       destination      = cp_egress_iterator.value["destination"]
#       destination_type = cp_egress_iterator.value["destination_type"]
#       protocol         = cp_egress_iterator.value["protocol"]
#       stateless        = cp_egress_iterator.value["stateless"]

#       dynamic "tcp_options" {
#         for_each = cp_egress_iterator.value["protocol"] == local.tcp_protocol && cp_egress_iterator.value["port"] != -1 ? [1] : []

#         content {
#           min = cp_egress_iterator.value["port"]
#           max = cp_egress_iterator.value["port"]
#         }
#       }

#     }
#   }

#   dynamic "ingress_security_rules" {
#     iterator = cp_ingress_iterator
#     for_each = local.cp_ingress_seclist

#     content {
#       description = cp_ingress_iterator.value["description"]
#       protocol    = cp_ingress_iterator.value["protocol"]
#       source      = cp_ingress_iterator.value["source"]
#       stateless   = cp_ingress_iterator.value["stateless"]
#       source_type = cp_ingress_iterator.value["source_type"]

#       dynamic "tcp_options" {
#         for_each = cp_ingress_iterator.value["protocol"] == local.tcp_protocol && cp_ingress_iterator.value["port"] != -1 ? [1] : []

#         content {
#           min = cp_ingress_iterator.value["port"]
#           max = cp_ingress_iterator.value["port"]
#         }
#       }
#     }
#   }


#   lifecycle {
#     ignore_changes = [
#       egress_security_rules, ingress_security_rules, defined_tags
#     ]
#   }
# }
