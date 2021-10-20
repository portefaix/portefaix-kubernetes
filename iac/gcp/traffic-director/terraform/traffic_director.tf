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

module "test" {
  source = "/home/nicolas/Projects/terraform-google-traffic-director"

  # project = var.project
  # region  = var.region

  network_name = var.network_name

  gke_service_name = var.gke_service_name
  gke_service_port = var.gke_service_port

  neg_name = var.neg_name
  neg_zone = var.neg_zone

  hc_timeout_sec        = var.hc_timeout_sec
  hc_check_interval_sec = var.hc_check_interval_sec
  hc_log_config         = var.hc_log_config
}