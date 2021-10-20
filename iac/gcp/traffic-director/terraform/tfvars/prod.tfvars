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

project = "portefaix-prod"

region = "europe-west1"

############################################################################
# VPC

network_name = "portefaix-prod"

##############################################################################
# Traffic Director

gke_service_name = "service-test"
gke_service_port = 80

neg_name = "service-test-neg"
neg_zone = "europe-west1-c"

hc_timeout_sec        = 5
hc_check_interval_sec = 5
hc_log_config         = true
