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

######################################################################
# Provider

project = "portefaix-dev"

region = "europe-west1"

##############################################################################
# VPC

network_name = "portefaix-dev"

############################################################################
# Bastion

# bastion_ip_address_name = "portefaix-dev-bastion"

############################################################################
# PubSub

topic_name = "portefaix-dev-gke-updates"

###########################################################################
# Kubernetes cluster

name = "portefaix-dev-cluster-gke"

regional = false
# location = "europe-west1-c"
zones = ["europe-west1-c"]

release_channel = "REGULAR"

ip_range_pods     = "portefaix-dev-gke-pods"
ip_range_services = "portefaix-dev-gke-services"

master_ipv4_cidr_block = "10.0.63.0/28"

cluster_resource_labels = {
  env               = "dev"
  service           = "kubernetes"
  made-by           = "terraform"
  portefaix-version = "v0-43-0"
}

enable_vertical_pod_autoscaling = false
horizontal_pod_autoscaling      = true
http_load_balancing             = true
network_policy                  = false
network_policy_provider         = "CALICO"
datapath_provider               = "ADVANCED_DATAPATH"
enable_shielded_nodes           = true
enable_binary_authorization     = false
enable_intranode_visibility     = false
identity_namespace              = "enabled"
istio                           = false
dns_cache                       = true
cloudrun                        = false
gce_pd_csi_driver               = true
config_connector                = false
enable_confidential_nodes       = false # True, depends on : n2d

logging_service    = "logging.googleapis.com/kubernetes"
monitoring_service = "monitoring.googleapis.com/kubernetes"

# notification_config_topic = ""

default_max_pods_per_node = 110

maintenance_start_time = "2019-08-01T03:00:00Z"
maintenance_end_time   = "2019-08-01T08:00:00Z"
maintenance_exclusions = [
  {
    name       = "Data Job"
    start_time = "2022-05-21T00:00:00Z"
    end_time   = "2022-05-21T23:59:00Z"
    exclusion_options = {
      scope = "NO_UPGRADES"
    }
  },
  {
    name       = "Happy new year"
    start_time = "2022-01-01T00:00:00Z"
    end_time   = "2022-01-02T23:59:00Z"
    exclusion_options = {
      scope = "NO_UPGRADES"
    }
  }
]
maintenance_recurrence = "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"

cluster_autoscaling = {
  enabled             = false
  autoscaling_profile = "BALANCED"
  max_cpu_cores       = 0
  min_cpu_cores       = 0
  max_memory_gb       = 0
  min_memory_gb       = 0
  gpu_resources       = []
}

enable_private_nodes = true

create_service_account = true

remove_default_node_pool = true
initial_node_count       = 0

node_pools = [
  {
    name            = "core"
    machine_type    = "e2-standard-8"
    node_locations  = "europe-west1-c"
    min_count       = 1
    max_count       = 3
    local_ssd_count = 0
    disk_size_gb    = 100
    disk_type       = "pd-ssd"
    image_type      = "COS_CONTAINERD"
    auto_repair     = true
    auto_upgrade    = true
    service_account = ""
    # preemptible        = false
    spot               = false
    initial_node_count = 2
  },
  {
    name            = "ops"
    machine_type    = "e2-standard-8"
    node_locations  = "europe-west1-c"
    min_count       = 0
    max_count       = 1
    local_ssd_count = 0
    disk_size_gb    = 100
    disk_type       = "pd-ssd"
    image_type      = "COS_CONTAINERD"
    auto_repair     = true
    auto_upgrade    = true
    service_account = ""
    # preemptible        = true
    spot               = true
    initial_node_count = 0
  },
]

node_pools_oauth_scopes = {
  all = [
    "https://www.googleapis.com/auth/cloud-platform"
  ]

  core = []

  ops = []
}

node_pools_labels = {
  all = {
    env               = "dev"
    service           = "kubernetes"
    made-by           = "terraform"
    portefaix-version = "v0-43-0"
  }

  core = {
    node-pool = "core"
  }

  ops = {
    node-pool = "ops"
  }

}

node_pools_metadata = {
  all = {}

  core = {}

  ops = {}
}

node_pools_taints = {
  all = []

  core = []

  ops = [
    {
      key    = "role"
      value  = "ops"
      effect = "PREFER_NO_SCHEDULE"
    },
  ]
}

node_pools_tags = {
  all = ["kubernetes", "nodes"]

  core = [
    "core",
  ]

  ops = [
    "ops"
  ]
}
