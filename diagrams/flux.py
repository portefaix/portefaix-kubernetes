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
from diagrams.k8s import storage
from diagrams.k8s import rbac


import cloud


def cloud_provider_resources(cloud_provider):
    iam = cloud.iam(cloud_provider, "iam")
    vault = cloud.vault(cloud_provider, "vault")
    return iam, vault


def architecture(cloud_provider, output, direction):
    with diagrams.Diagram("flux_%s" % cloud_provider, show=False):
        with diagrams.Cluster("Cloud Platform"):
            iam, vault = cloud_provider_resources(cloud_provider)

            with diagrams.Cluster("Kubernetes Cluster"):

                clusterRole = rbac.ClusterRole()
                clusterRoleBinding = rbac.ClusterRoleBinding()

                with diagrams.Cluster("flux-system"):
                    sa = rbac.ServiceAccount()
                    clusterRole << clusterRoleBinding >> sa
                    role = rbac.Role()
                    roleBinding = rbac.RoleBinding()
                    role << roleBinding >> sa

                    source_deploy = compute.Deployment("source-controller")
                    source_pod = compute.Pod()
                    source_svc = network.Service()
                    source_deploy >> source_pod
                    source_svc >> source_pod

                    kustomize_deploy = compute.Deployment("kustomize-controller")
                    kustomize_pod = compute.Pod()
                    kustomize_svc = network.Service()
                    kustomize_deploy >> kustomize_pod
                    kustomize_svc >> kustomize_pod

                    helm_deploy = compute.Deployment("helm-controller")
                    helm_pod = compute.Pod()
                    helm_svc = network.Service()
                    helm_deploy >> helm_pod
                    helm_svc >> helm_pod

                    notif_deploy = compute.Deployment("notification-controller")
                    notif_pod = compute.Pod()
                    notif_svc = network.Service()
                    notif_deploy >> notif_pod
                    notif_svc >> notif_pod

                    sa >> [source_deploy, kustomize_deploy, helm_deploy, notif_deploy]
                    sa >> iam

                    kustomize_pod >> vault
                    helm_pod >> vault




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
