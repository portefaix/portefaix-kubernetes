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

import diagrams
from diagrams.k8s import compute
from diagrams.k8s import network
from diagrams.k8s import rbac

import cloud


def cloud_provider_resources(cloud_provider):
    iam = cloud.iam(cloud_provider, "iam")
    bucket = cloud.bucket(cloud_provider, "bucket")
    return iam, bucket


def architecture(cloud_provider, output, direction):
    with diagrams.Diagram("velero_%s" % cloud_provider, show=False, direction="TB"):
        with diagrams.Cluster("Cloud Platform"):
            iam, bucket = cloud_provider_resources(cloud_provider)

            with diagrams.Cluster("Kubernetes Cluster"):
                clusterRole = rbac.ClusterRole()
                clusterRoleBinding = rbac.ClusterRoleBinding()

                with diagrams.Cluster("storage"):
                    sa = rbac.ServiceAccount()
                    clusterRole << clusterRoleBinding >> sa
                    role = rbac.Role()
                    roleBinding = rbac.RoleBinding()
                    role << roleBinding >> sa

                    dep = compute.Deployment("certmanager")
                    svc = network.Service()
                    dep << svc

                    sa >> dep
                    sa >> iam
                    dep >> bucket


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
