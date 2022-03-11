# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

data "ibm_resource_group" "this" {
  name = var.resource_group_name
}

data "ibm_is_vpc" "this" {
  name = var.vpc_name
}

data "ibm_is_subnets" "this" {
  resource_group = data.ibm_resource_group.this.id
}

data "ibm_container_vpc_cluster" "this" {
  resource_group_id = data.ibm_resource_group.this.id
  name              = module.iks.kubernetes_vpc_cluster_id
}
