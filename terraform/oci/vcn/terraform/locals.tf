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

locals {
  # control_plane_subnet_name = format("%s-control-plane", var.vcn_name)
  # controler_plane_seclist_name = format("%s-control-plane", var.vcn_name)
  # workers_subnet_name = format("%s-workers", var.vcn_name)
  # pub_lb_subnet_name = format("%s-pub-lb", var.vcn_name)
  # int_lb_subnet_name = format("%s-int-lb", var.vcn_name)

  # health_check_port = 10256

  # anywhere = "0.0.0.0/0"
  # all_protocols = "all"
  # icmp_protocol = 1
  # tcp_protocol = 6
  # udp_protocol = 17

  # # Oracle Cloud Services network
  # osn = lookup(data.oci_core_services.all_oci_services.services[0], "cidr_block")

  # # control plane
  # cp_egress_seclist = [
  #   {
  #     description      = "Allow Bastion service to communicate to the control plane endpoint. Managed by Terraform",
  #     destination      = var.control_plane_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.tcp_protocol,
  #     port             = 6443,
  #     stateless        = false
  #   }
  # ]

  # cp_ingress_seclist = [
  #   {
  #     description = "Allow Bastion service to communicate to the control plane endpoint. Managed by Terraform",
  #     source      = var.control_plane_cidr,
  #     source_type = "CIDR_BLOCK",
  #     protocol    = local.tcp_protocol,
  #     port        = 6443,
  #     stateless   = false
  #   }
  # ]

  # # control plane
  # cp_egress = [
  #   {
  #     description      = "Allow Kubernetes Control plane to communicate to the control plane subnet. Managed by Terraform",
  #     destination      = var.control_plane_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.tcp_protocol,
  #     port             = 6443,
  #     stateless        = false
  #   },
  #   {
  #     description      = "Allow Kubernetes control plane to communicate with OKE",
  #     destination      = local.osn,
  #     destination_type = "SERVICE_CIDR_BLOCK",
  #     protocol         = local.tcp_protocol,
  #     port             = 443,
  #     stateless        = false
  #   },
  #   {
  #     description      = "Allow all TCP traffic from control plane to worker nodes",
  #     destination      = var.workers_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.tcp_protocol,
  #     port             = -1,
  #     stateless        = false
  #   },
  #   {
  #     description      = "Allow ICMP traffic for path discovery to worker nodes",
  #     destination      = var.workers_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.icmp_protocol,
  #     port             = -1,
  #     stateless        = false
  #   },
  # ]

  # cp_ingress = [
  #   {
  #     description = "Allow worker nodes to control plane API endpoint communication"
  #     protocol    = local.tcp_protocol,
  #     port        = 6443,
  #     source      = var.workers_cidr,
  #     source_type = "CIDR_BLOCK",
  #     stateless   = false
  #   },
  #   {
  #     description = "Allow worker nodes to control plane communication"
  #     protocol    = local.tcp_protocol,
  #     port        = 12250,
  #     source      = var.workers_cidr,
  #     source_type = "CIDR_BLOCK",
  #     stateless   = false
  #   },
  #   {
  #     description = "Allow ICMP traffic for path discovery from worker nodes"
  #     protocol    = local.icmp_protocol,
  #     port        = -1,
  #     source      = var.workers_cidr,
  #     source_type = "CIDR_BLOCK",
  #     stateless   = false
  #   },
  #   # {
  #   #   description = "Allow operator host access to control plane. Required for kubectl/helm."
  #   #   protocol    = local.tcp_protocol,
  #   #   port        = 6443,
  #   #   source      = local.operator_subnet,
  #   #   source_type = "CIDR_BLOCK",
  #   #   stateless   = false
  #   # },
  # ]

  # # workers
  # workers_egress = [
  #   {
  #     description      = "Allow egress for all traffic to allow pods to communicate between each other on different worker nodes on the worker subnet",
  #     destination      = var.workers_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.all_protocols,
  #     port             = -1,
  #     stateless        = false
  #   },
  #   {
  #     description      = "Allow ICMP traffic for path discovery",
  #     destination      = var.workers_cidr
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.icmp_protocol,
  #     port             = -1,
  #     stateless        = false
  #   },
  #   {
  #     description      = "Allow worker nodes to communicate with OKE",
  #     destination      = local.osn,
  #     destination_type = "SERVICE_CIDR_BLOCK",
  #     protocol         = local.tcp_protocol,
  #     port             = -1,
  #     stateless        = false
  #   },
  #   {
  #     description      = "Allow worker nodes to control plane API endpoint communication",
  #     destination      = var.control_plane_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.tcp_protocol,
  #     port             = 6443,
  #     stateless        = false
  #   },
  #   {
  #     description      = "Allow worker nodes to control plane communication",
  #     destination      = var.control_plane_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.tcp_protocol,
  #     port             = 12250,
  #     stateless        = false
  #   }
  # ]

  # workers_ingress = [
  #   {
  #     description = "Allow ingress for all traffic to allow pods to communicate between each other on different worker nodes on the worker subnet",
  #     protocol    = local.all_protocols,
  #     port        = -1,
  #     source      = var.workers_cidr,
  #     source_type = "CIDR_BLOCK",
  #     stateless   = false
  #   },
  #   {
  #     description = "Allow control plane to communicate with worker nodes",
  #     protocol    = local.tcp_protocol,
  #     port        = -1,
  #     source      = var.control_plane_cidr,
  #     source_type = "CIDR_BLOCK",
  #     stateless   = false
  #   },
  #   {
  #     description = "Allow path discovery from worker nodes"
  #     protocol    = local.icmp_protocol,
  #     port        = -1,
  #     //this should be local.worker_subnet?
  #     source      = local.anywhere,
  #     source_type = "CIDR_BLOCK",
  #     stateless   = false
  #   }
  # ]

  # int_lb_egress = [
  #   {
  #     description      = "Allow stateful egress to workers. Required for NodePorts",
  #     destination      = var.workers_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.tcp_protocol,
  #     port             = "30000-32767",
  #     stateless        = false
  #   },
  #   {
  #     description      = "Allow ICMP traffic for path discovery to worker nodes",
  #     destination      = var.workers_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.icmp_protocol,
  #     port             = -1,
  #     stateless        = false
  #   },
  #   {
  #     description      = "Allow stateful egress to workers. Required for load balancer http/tcp health checks",
  #     destination      = var.workers_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.tcp_protocol,
  #     port             = local.health_check_port,
  #     stateless        = false
  #   },
  # ]

  # pub_lb_egress = [
  #   {
  #     description      = "Allow stateful egress to internal load balancers subnet on port 80",
  #     destination      = var.int_lb_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.tcp_protocol,
  #     port             = 80
  #     stateless        = false
  #   },
  #   {
  #     description      = "Allow stateful egress to internal load balancers subnet on port 443",
  #     destination      = var.int_lb_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.tcp_protocol,
  #     port             = 443
  #     stateless        = false
  #   },
  #   {
  #     description      = "Allow stateful egress to workers. Required for NodePorts",
  #     destination      = var.workers_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.tcp_protocol,
  #     port             = "30000-32767",
  #     stateless        = false
  #   },
  #   {
  #     description      = "Allow ICMP traffic for path discovery to worker nodes",
  #     destination      = var.workers_cidr,
  #     destination_type = "CIDR_BLOCK",
  #     protocol         = local.icmp_protocol,
  #     port             = -1,
  #     stateless        = false
  #   },
  # ]
}
