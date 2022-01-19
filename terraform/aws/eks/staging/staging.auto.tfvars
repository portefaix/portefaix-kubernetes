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

#############################################################################
# Provider

region = "eu-west-3"

#############################################################################
# Networking

vpc_name = "portefaix-staging"

#############################################################################
# Kubernetes cluster

cluster_name = "portefaix-staging-eks"

cluster_version = "1.21"
tags = {
  "Name"              = "portefaix-staging-eks"
  "Env"               = "staging"
  "Service"           = "kubernetes"
  "Portefaix-Version" = "0.28.0"
}

cluster_tags = {
  "Role" = "cluster"
}

node_groups_defaults = {
  ami_type = "AL2_x86_64"
  # Graviton 2
  # ami_type  = "AL2_ARM_64"
  disk_size = 50
}

node_groups = {
  core = {
    desired_capacity = 3
    max_capacity     = 5
    min_capacity     = 1
    instance_types   = ["t3.medium"]
    # Graviton 2
    # instance_types = ["m6g.large"]
    key_name = ""
    name     = "portefaix-staging-eks-core"

    k8s_labels = {
      Name    = "portefaix-staging-eks-core"
      Env     = "staging"
      Service = "kubernetes"
    }
    additional_tags = {
      NodePool = "core"
    }
  }
  ops = {
    desired_capacity = 0
    max_capacity     = 1
    min_capacity     = 0

    instance_types = ["t3.medium"]
    # Graviton 2
    # instance_types = ["m6g.large"]
    capacity_type = "SPOT"
    key_name      = ""
    name          = "portefaix-staging-eks-ops"

    k8s_labels = {
      Name    = "portefaix-staging-eks-ops"
      Env     = "staging"
      Service = "kubernetes"
    }
    additional_tags = {
      NodePool = "ops"
    }
    taints = [
      {
        key    = "role"
        value  = "ops"
        effect = "PREFER_NO_SCHEDULE"
      }
    ]
  }
}

map_roles = []
# map_users = []

#############################################################################
# EBS CSI Driver

# ebs_csi_controller_role_name = "ebs-csi-driver-controller"

ebs_csi_controller_sa_name   = "ebs-csi-controller"
ebs_csi_controller_namespace = "kube-system"

ebs_csi_driver_tags = {
  "Role"  = "csi-driver"
  "Addon" = "ebs-csi-driver"
}

#############################################################################
# EFS CSI Driver

# efs_csi_controller_role_name = "efs-csi-driver-controller"

efs_csi_controller_sa_name   = "efs-csi-controller"
efs_csi_controller_namespace = "kube-system"

efs_csi_driver_tags = {
  "Role"  = "csi-driver"
  "Addon" = "efs-csi-driver"
}

#############################################################################
# FSX CSI Driver

# fsx_csi_controller_role_name = "fsx-csi-driver-controller"

fsx_csi_controller_sa_name   = "fsx-csi-controller"
fsx_csi_controller_namespace = "kube-system"

fsx_csi_driver_tags = {
  "Role"  = "csi-driver"
  "Addon" = "fsx-csi-driver"
}

#############################################################################
# Secret Store CSI Driver

# secret_store_csi_controller_role_name = "secret-store-csi-driver-controller"

secret_store_csi_driver_tags = {
  "Role"  = "csi-driver"
  "Addon" = "secret-store-csi-driver"
}
secrets_data = []

#############################################################################
# AWS ALB Controller

alb_controller_sa_name   = "aws-load-balancer-controller"
alb_controller_namespace = "kube-system"

alb_controller_tags = {
  "Role"  = "aws-alb-controller"
  "Addon" = "load-balancer"
}

#############################################################################
# AppMesh Controller

appmesh_sa_name   = "appmesh-controller"
appmesh_namespace = "appmesh-system"

appmesh_tags = {
  "Role"  = "appmesh-controller"
  "Addon" = "appmesh"
}

#############################################################################
# Cluster Autoscaler

cluster_autoscaler_sa_name   = "cluster-autoscaler-controller"
cluster_autoscaler_namespace = "kube-system"

cluster_autoscaler_tags = {
  "Role"  = "cluster-autoscaler-controller"
  "Addon" = "cluster-autoscaler"
}

#############################################################################
# EKS Addons

addon_vpc_cni_version    = "v1.9.0-eksbuild.1"
addon_coredns_version    = "v1.8.4-eksbuild.1"
addon_kube_proxy_version = "v1.21.2-eksbuild.2"
