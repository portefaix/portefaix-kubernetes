#!/usr/bin/python3

# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

import argparse

import diagrams
from diagrams.gcp import compute as compute_gcp
from diagrams.k8s import compute
from diagrams.k8s import network
from diagrams.k8s import rbac


def k8s_rbac():
    sa = rbac.ServiceAccount()
    clusterRole = rbac.ClusterRole()
    clusterRoleBinding = rbac.ClusterRoleBinding()
    clusterRole << clusterRoleBinding >> sa
    # role = rbac.Role()
    # roleBinding = rbac.RoleBinding()
    # role << roleBinding >> sa
    return sa


def architecture(cloud_provider, output, direction):
    with diagrams.Diagram("prometheus_operator", show=False):
        with diagrams.Cluster("Cloud Platform"):
            with diagrams.Cluster("Kubernetes Cluster"):
                sa = k8s_rbac()

                with diagrams.Cluster("monitoring"):
                    sm = compute_gcp.KubernetesEngine("servicemonitor")
                    svc = network.Service()
                    dep = compute.Deployment()
                    pod = compute.Pod()

                    dep << sa
                    dep >> pod
                    svc >> pod
                    sm >> svc


def main(cloud_provider, output, direction):
    architecture(args.cloud, args.output, args.direction)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-o",
        "--output",
        type=str,
        choices=__outformats,
        default="png",
        help="Output format",
    )
    parser.add_argument(
        "-d",
        "--direction",
        type=str,
        choices=__directions,
        default="LR",
        help="Diagram direction",
    )
    parser.add_argument(
        "-c",
        "--cloud",
        type=str,
        choices=__cloud_providers,
        # default="gcp",
        help="Cloud provider",
    )
    args = parser.parse_args()
    main(args.cloud, args.output, args.direction)
