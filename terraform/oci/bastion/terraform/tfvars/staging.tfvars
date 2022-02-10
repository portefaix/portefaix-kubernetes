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

#####################################################################""
# Provider

region = "uk-london-1"

##############################################################################
# Bastion

label_prefix = "portefaix-staging"

vcn_display_name            = "portefaix-staging-core"
ig_route_table_display_name = "portefaix-staging-nat-route"

bastion_image_id   = "Autonomous"
bastion_os_version = "7.9"

bastion_shape = {
  shape = "VM.Standard.E4.Flex", ocpus = 1, memory = 4, boot_volume_size = 50
}

freeform_tags = {
  project = "portefaix-staging"
  env     = "staging"
  service = "bastion"
  made-by = "terraform"
}
