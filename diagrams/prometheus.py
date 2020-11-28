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
from diagrams.aws import security as aws_security
from diagrams.aws import storage as aws_storage
from diagrams.gcp import compute as gcp_compute
from diagrams.gcp import security as gcp_security
from diagrams.gcp import storage as gcp_storage
from diagrams.k8s import compute
from diagrams.k8s import network
from diagrams.k8s import podconfig
from diagrams.k8s import rbac
from diagrams.k8s import storage

import cloud


def cloud_provider_resources(cloud_provider):
    iam = cloud.iam(cloud_provider, "iam")
    disk = cloud.disk(cloud_provider, "disk")
    return iam, disk


def architecture(cloud_provider, output, direction):
    with diagrams.Diagram("prometheus_%s" % cloud_provider, show=False):
        with diagrams.Cluster("Cloud Platform"):
            pv = storage.PV()
            iam, disk = cloud_provider_resources(cloud_provider)

            with diagrams.Cluster("Kubernetes Cluster"):
                sc = storage.StorageClass()
                pvc = storage.PVC()
                sc << pvc

                clusterRole = rbac.ClusterRole()
                clusterRoleBinding = rbac.ClusterRoleBinding()

                with diagrams.Cluster("monitoring"):
                    sa = rbac.ServiceAccount()
                    clusterRole << clusterRoleBinding >> sa
                    role = rbac.Role()
                    roleBinding = rbac.RoleBinding()
                    role << roleBinding >> sa

                    # apiserver = APIServer()
                    sm = gcp_compute.KubernetesEngine("servicemonitor")
                    svc = network.Service()
                    sts = compute.StatefulSet()
                    # secret = podconfig.Secret()

                    pvc >> pv
                    sts << sa
                    sm >> svc
                    sts >> pvc

                    pod = compute.Pod()
                    # pod >> secret
                    pod << sts
                    pod >> pv
                    svc >> pod

                    sa >> iam
                    pv >> disk


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
