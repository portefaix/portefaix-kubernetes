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

module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.2.0"

  compartment_id = var.compartment_ocid

  label_prefix = var.label_prefix

  vcn_name  = var.vcn_name
  vcn_cidrs = var.vcn_cidrs

  create_internet_gateway       = var.create_internet_gateway
  internet_gateway_display_name = var.internet_gateway_display_name

  create_nat_gateway       = var.create_nat_gateway
  nat_gateway_display_name = var.nat_gateway_display_name

  create_service_gateway       = var.create_service_gateway
  service_gateway_display_name = var.service_gateway_display_name

  # nat_gateway_public_ip_id = var.nat_gateway_public_ip_id

  freeform_tags = var.freeform_tags
}
