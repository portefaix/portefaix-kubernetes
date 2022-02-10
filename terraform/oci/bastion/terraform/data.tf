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

data "oci_core_vcns" "this" {
  compartment_id = var.compartment_id
  display_name   = var.vcn_display_name
}

data "oci_core_route_tables" "this" {
  compartment_id = var.compartment_id
  display_name   = var.ig_route_table_display_name
  vcn_id         = local.vcn_id
}
