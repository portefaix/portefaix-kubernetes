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

#############################################################################
# Provider

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags for the AWS provider"
  default = {
    "Project"           = "Portefaix"
    "Made-By"           = "Terraform"
    "Portefaix-Version" = "v0.41.0"
  }
}

#############################################################################
# Project

variable "org_name" {
  type        = string
  description = "Name of the AWS Organization"
}

variable "core_account_id" {
  type        = string
  description = "ID of the Core AWS Account"
}


#############################################################################
# Networking

variable "vpc_name" {
  type        = string
  description = "ID of the VPC"
}

#############################################################################
# Kubernetes cluster


variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "cluster_version" {
  type        = string
  description = "The EKS Kubernetes version"
}

variable "tags" {
  description = "A map of tags to add to all resources. Tags added to launch configuration or templates override these values for ASG Tags only."
  type        = map(string)
  default = {
    "Service" = "Kubernetes"
  }
}

variable "cluster_tags" {
  description = "A map of tags to add to just the eks resource."
  type        = map(string)
  default = {
    "Role" = "EKS Cluster"
  }
}

variable "self_managed_node_groups" {
  description = "Map of self-managed node group definitions to create"
  type        = any
  default     = {}
}

variable "self_managed_node_group_defaults" {
  description = "Map of self-managed node group default configurations"
  type        = any
  default     = {}
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions to create"
  type        = any
  default     = {}
}

variable "eks_managed_node_group_defaults" {
  description = "Map of EKS managed node group default configurations"
  type        = any
  default     = {}
}
variable "fargate_profiles" {
  description = "Map of Fargate Profile definitions to create"
  type        = any
  default     = {}
}

variable "fargate_profile_defaults" {
  description = "Map of Fargate Profile default configurations"
  type        = any
  default     = {}
}

variable "cluster_addons" {
  description = "Map of cluster addon configurations to enable for the cluster. Addon name can be the map keys or set with `name`"
  type        = any
  default     = {}
}

#############################################################################
# EBS CSI Driver

# variable "ebs_csi_controller_role_name" {
#   description = "The name of the EBS CSI driver IAM role"
#   type        = string
#   default     = "ebs-csi-driver-controller"
# }

# variable "ebs_csi_controller_role_policy_name" {
#   description = "The prefix of the EBS CSI driver IAM policy"
#   default     = "AmazonEKS_EBS_CSI_Driver_Policy"
#   type        = string
# }

variable "ebs_csi_driver_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "ebs_csi_controller_sa_name" {
  description = "Controller name"
  type        = string
  default     = "ebs-csi-controller"
}

variable "ebs_csi_controller_namespace" {
  description = "The K8s namespace for all EBS CSI driver resources"
  type        = string
  default     = "kube-system"
}

#############################################################################
# EFS CSI Driver

# variable "efs_csi_controller_role_name" {
#   description = "The name of the EFS CSI driver IAM role"
#   type        = string
#   default     = "efs-csi-driver-controller"
# }

# variable "efs_csi_controller_role_policy_name" {
#   description = "The prefix of the EFS CSI driver IAM policy"
#   default     = "AmazonEKS_EFS_CSI_Driver_Policy"
#   type        = string
# }

variable "efs_csi_driver_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "efs_csi_controller_sa_name" {
  description = "Controller name"
  type        = string
  default     = "efs-csi-controller"
}

variable "efs_csi_controller_namespace" {
  description = "The K8s namespace for all EFS CSI driver resources"
  type        = string
  default     = "kube-system"
}

#############################################################################
# FSX CSI Driver

# variable "fsx_csi_controller_role_name" {
#   description = "The name of the FSX CSI driver IAM role"
#   type        = string
#   default     = "fsx-csi-driver-controller"
# }

# variable "fsx_csi_controller_role_policy_name" {
#   description = "The prefix of the FSX CSI driver IAM policy"
#   default     = "AmazonEKS_FSX_CSI_Driver_Policy"
#   type        = string
# }

variable "fsx_csi_driver_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "fsx_csi_controller_sa_name" {
  description = "Controller name"
  type        = string
  default     = "fsx-csi-controller"
}

variable "fsx_csi_controller_namespace" {
  description = "The K8s namespace for all FSX CSI driver resources"
  type        = string
  default     = "kube-system"
}

#############################################################################
# Secret Store CSI Driver

#tfsec:ignore:GEN001
# variable "secret_store_csi_controller_role_name" {
#   description = "The name of the Secret Store CSI driver IAM role"
#   type        = string
#   default     = "secret-store-csi-driver"
# }

# #tfsec:ignore:GEN001
# variable "secret_store_csi_controller_role_policy_name" {
#   description = "The prefix of the Secret Store CSI driver IAM policy"
#   default     = "AmazonEKS_SecretStore_CSI_Driver_Policy"
#   type        = string
# }

variable "secret_store_csi_driver_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "secrets_data" {
  description = "Secret Store CSI Driver data"
  type = list(object({
    name      = string
    prefix    = string
    namespace = string
    sa_name   = string
  }))
  default = []
}


#############################################################################
# AWS ALB Controller

# variable "alb_controller_role_name" {
#   description = "The name of the EBS CSI driver IAM role"
#   type        = string
#   default     = "aws-load-balancer-controller"
# }

# variable "alb_controller_role_policy_name" {
#   description = "The prefix of the EBS CSI driver IAM policy"
#   default     = "AWSLoadBalancerControllerIAMPolicy"
#   type        = string
# }

variable "alb_controller_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "alb_controller_sa_name" {
  description = "Controller name"
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "alb_controller_namespace" {
  description = "The K8s namespace for ALB Controller resources"
  type        = string
  default     = "kube-system"
}


#############################################################################
# AppMesh Controller

# variable "appmesh_controller_role_name" {
#   description = "The name of the AppMesh Controller IAM role"
#   type        = string
#   default     = "appmesh-controller"
# }

# variable "appmesh_controller_role_policy_name" {
#   description = "The name of the AppMesh Controller IAM policy"
#   default     = "AWSAppMeshK8sControllerIAMPolicy"
#   type        = string
# }

variable "appmesh_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "appmesh_sa_name" {
  description = "Controller name"
  type        = string
  default     = "appmesh-controller"
}

variable "appmesh_namespace" {
  description = "The K8s namespace for ALB Controller resources"
  type        = string
  default     = "appmesh-system"
}

#############################################################################
# Cluster Autoscaler

# variable "cluster_autoscaler_role_name" {
#   description = "The name of the AppMesh Controller IAM role"
#   type        = string
#   default     = "cluster-autoscaler-controller"
# }

# variable "cluster_autoscaler_role_policy_name" {
#   description = "The name of the AppMesh Controller IAM policy"
#   default     = "AWSClusterAutoscalerIAMPolicy"
#   type        = string
# }

variable "cluster_autoscaler_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "cluster_autoscaler_sa_name" {
  description = "Controller name"
  type        = string
  default     = "cluster-autoscaler-controller"
}

variable "cluster_autoscaler_namespace" {
  description = "The K8s namespace for  resources"
  type        = string
  default     = "kube-system"
}

#############################################################################
# Node Terminaison Handler

variable "node_termination_handler_role_name" {
  description = "The name of the AppMesh Controller IAM role"
  type        = string
  default     = "node-terminaison-handler"
}

variable "node_termination_handler_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "node_termination_handler_sa_name" {
  description = "Controller name"
  type        = string
  default     = "node-terminaison-handler"
}

variable "node_termination_handler_namespace" {
  description = "The K8s namespace for resources"
  type        = string
  default     = "kube-system"
}

#############################################################################
# Karpenter

variable "karpenter_role_name" {
  description = "The name of the AppMesh Controller IAM role"
  type        = string
  default     = "karpenter"
}

variable "karpenter_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "karpenter_sa_name" {
  description = "Controller name"
  type        = string
  default     = "karpenter"
}

variable "karpenter_namespace" {
  description = "The K8s namespace for resources"
  type        = string
  default     = "kube-system"
}

variable "karpenter_node_group_name" {
  type        = string
  description = "Node Group name for Karpenter"
}

#############################################################################
# External Secrets Operator

variable "eso_role_name" {
  description = "The name of the ESO IAM role"
  type        = string
  default     = "eso-controller"
}

variable "eso_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "eso_sa_name" {
  description = "Controller name"
  type        = string
  default     = "eso-controller"
}

variable "eso_namespace" {
  description = "The K8s namespace for all ESO resources"
  type        = string
  default     = "kube-system"
}

variable "eso_secrets_arns" {
  type        = list(string)
  description = "List of Secrets Manager ARNs that contain secrets to mount using External Secrets Operator"
  default     = []
}
