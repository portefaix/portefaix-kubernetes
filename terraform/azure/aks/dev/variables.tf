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

############################################################################
# Provider

#variable subscription_id {
#  type        = string
#  description = "The Subscription ID which should be used"
#}

#############################################################################
# Networking


variable "aks_subnet_name" {
  type        = string
  description = "Name of the AKS subnet"
}

variable "appgw_subnet_name" {
  type        = string
  description = "Name of the Application Gateway subnet"
}

variable "virtual_network_name" {
  type        = string
  description = "Name of the Virtual Network this Subnet is located within"
}

variable "vnet_resource_group_name" {
  type        = string
  description = "The Name which should be used for the networking Resource Group"
}

#############################################################################
# Active Directory

# variable "aad_group_name" {
#   description = "Name of the Azure AD group for cluster-admin access"
#   type        = string
# }

#############################################################################
# Kubernetes cluster

variable "aks_resource_group_name" {
  type        = string
  description = "Name of the resource group for AKS"
}

variable "aks_resource_group_location" {
  type        = string
  description = "The Azure Region where the Resource Group for AKS should exist."
}


variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "prefix" {
  description = "(Required) The prefix for the resources created in the specified Azure Resource Group"
  type        = string
}

variable "kubernetes_version" {
  type        = string
  description = "The AKS Kubernetes version"
}

variable "private_cluster_enabled" {
  description = "If true cluster API server will be exposed only on internal IP address and available only in cluster vnet."
  type        = bool
}

# variable "authorized_ip_ranges" {
#   type        = list(string)
#   description = "The IP ranges to whitelist for incoming traffic to the masters."
# }

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}

variable "public_ssh_key" {
  description = "A custom ssh key to control access to the AKS cluster"
  type        = string
  default     = ""
}

#############################################################################
# Network profile

variable "network_plugin" {
  type        = string
  description = "The CNI network plugin to use (only azure, or kubenet)"
  default     = "kubenet"
}

variable "network_policy" {
  description = "The network polcy for the CNI. Only used when network_plugin is set to azure. Supported values: calico, azure"
  type        = string
}

variable "net_profile_dns_service_ip" {
  description = "(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "net_profile_docker_bridge_cidr" {
  description = "(Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

# variable "net_profile_outbound_type" {
#   description = "(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer."
#   type        = string
#   default     = "loadBalancer"
# }

# variable "net_profile_pod_cidr" {
#   description = " (Optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created."
#   type        = string
#   default     = null
# }

variable "net_profile_service_cidr" {
  description = "(Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

#############################################################################
# Addon profile

variable "http_application_routing_enabled" {
  type        = bool
  description = "Is HTTP Application Routing Enabled"
}

# variable "aci_connector_linux" {
#   type        = bool
#   description = "Is the virtual node addon enabled"
# }

variable "azure_policy_enabled" {
  description = "Is the Azure Policy for Kubernetes Add On enabled"
  type        = bool
}

variable "ingress_application_gateway_enabled" {
  description = "If true will enable Application Gateway ingress controller to this Kubernetes Cluster"
  type        = bool
  default     = false
}

variable "open_service_mesh_enabled" {
  type        = bool
  description = "Is Open Service Mesh enabled."
  default     = null
}

variable "key_vault_secrets_provider_enabled" {
  type        = bool
  description = "Whether to use the Azure Key Vault Provider for Secrets Store CSI Driver in an AKS cluster"
  default     = false
}

variable "secret_rotation_enabled" {
  type        = bool
  description = "Is secret rotation enabled"
  default     = false
}

variable "workload_identity_enabled" {
  description = "Enable or Disable Workload Identity. Defaults to false."
  type        = bool
  default     = false
}

#############################################################################
# Default node pool

variable "os_disk_size_gb" {
  description = "Disk size of nodes in GBs."
  type        = number
}

variable "agents_size" {
  description = "The default virtual machine size for the Kubernetes agents"
  type        = string
}

variable "agents_count" {
  description = "The number of Agents that should exist in the Agent Pool. Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes."
  type        = number
}

variable "enable_auto_scaling" {
  description = "Enable node pool autoscaling"
  type        = bool
}

variable "agents_max_count" {
  type        = number
  description = "Maximum number of nodes in a pool"
}

variable "agents_min_count" {
  type        = number
  description = "Minimum number of nodes in a pool"
}

variable "agents_pool_name" {
  description = "The default Azure AKS agentpool (nodepool) name."
  type        = string
}

variable "agents_availability_zones" {
  description = "(Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
  type        = list(string)
}

variable "agents_labels" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created."
  type        = map(string)
}

variable "agents_type" {
  description = "(Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets."
  type        = string
  default     = "VirtualMachineScaleSets"
}

variable "agents_tags" {
  description = "(Optional) A mapping of tags to assign to the Node Pool."
  type        = map(string)
}

variable "agents_max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type        = number
}

variable "api_server_authorized_ip_ranges" {
  type        = set(string)
  description = "The IP ranges to allow for incoming traffic to the server nodes."
  default     = null
}

# Maintenance Windows

variable "maintenance_window" {
  type = object({
    allowed = list(object({
      day   = string
      hours = set(number)
    })),
    not_allowed = list(object({
      end   = string
      start = string
    })),
  })
  description = "(Optional) Maintenance configuration of the managed cluster."
  default     = null
}

#############################################################################
# Addons node pool

variable "node_pools" {
  description = "Addons node pools"
  type = list(object({
    name                = string
    vm_size             = string
    os_disk_size_gb     = number
    os_disk_type        = string
    priority            = string
    enable_auto_scaling = bool
    count               = number
    min_count           = number
    max_count           = number
    max_pods            = number
    taints              = list(string)
    labels              = map(string)
    tags                = map(string)
  }))
  default = []
}
