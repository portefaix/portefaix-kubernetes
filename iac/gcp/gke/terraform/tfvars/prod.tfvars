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

##############################################################################
# VPC

network_name = "portefaix-prod"


###########################################################################
# Kubernetes cluster

name = "portefaix-prod-cluster-gke"

location = "europe-west1-c"
zones    = ["europe-west1-c"]

release_channel = "REGULAR"

ip_range_pods     = "portefaix-prod-gke-pods"
ip_range_services = "portefaix-prod-gke-services"

master_ipv4_cidr_block = "10.0.63.0/28"

cluster_resource_labels = {
  env     = "prod"
  service = "kubernetes"
  made-by = "terraform"
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

logging_service    = "logging.googleapis.com/kubernetes"
monitoring_service = "monitoring.googleapis.com/kubernetes"

notification_config_topic = ""

default_max_pods_per_node = 110

maintenance_start_time = "05:00"
maintenance_exclusions = []
maintenance_end_time   = ""
maintenance_recurrence = ""

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

remove_default_node_pool = true
initial_node_count = 0

node_pools = [
    {
      name                      = "core"
      machine_type              = "e2-standard-8"
      node_locations            = "europe-west1-c"
      min_count                 = 1
      max_count                 = 3
      local_ssd_count           = 0
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS"
      auto_repair               = true
      auto_upgrade              = true
      service_account           = "project-service-account@portefaix-prod.iam.gserviceaccount.com"
      preemptible               = false
      initial_node_count        = 2
    },
    {
      name                      = "ops"
      machine_type              = "e2-standard-8"
      node_locations            = "europe-west1-c"
      min_count                 = 0
      max_count                 = 1
      local_ssd_count           = 0
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS"
      auto_repair               = true
      auto_upgrade              = true
      service_account           = "project-service-account@portefaix-prod.iam.gserviceaccount.com"
      preemptible               = false
      initial_node_count        = 0
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
      env     = "prod"
      service = "kubernetes"
      made-by = "terraform"
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