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
  source  = "oracle-terraform-modules/bastion/oci"
  version = "3.0.0"

  compartment_id = var.compartment_ocid

  label_prefix = var.label_prefix

  vcn_id      = data.oci_core_vcns.this.virtual_networks[0].id
  ig_route_id = data.oci_core_route_tables.this.route_tables[0].id

  bastion_access      = var.bastion_access
  bastion_image_id    = var.bastion_image_id
  bastion_os_version  = var.bastion_os_version
  bastion_shape       = var.bastion_shape
  bastion_state       = var.bastion_state
  bastion_timezone    = var.bastion_timezone
  bastion_type        = var.bastion_type
  ssh_public_key_path = var.ssh_public_key_path
  upgrade_bastion     = var.upgrade_bastion

  enable_bastion_notification = var.enable_bastion_notification

  freeform_tags = var.freeform_tags

  providers = {
    oci.home = oci.home
  }
}
