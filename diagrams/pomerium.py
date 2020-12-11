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
from diagrams.saas import identity

import cloud


def architecture(cloud_provider, output, direction):
    with diagrams.Diagram("pomerium", show=False, direction="TB"):

        auth0 = identity.Auth0("auth0")

        with diagrams.Cluster("Cloud Platform"):
            
            with diagrams.Cluster("Kubernetes Cluster"):
                clusterRole = rbac.ClusterRole("authorize")
                clusterRoleBinding = rbac.ClusterRoleBinding("authorize")

                with diagrams.Cluster("identity"):
                    sa_authenticate = rbac.ServiceAccount("authenticate")
                    dep_authenticate = compute.Deployment("authenticate")
                    svc_authenticate = network.Service("authenticate")
                    dep_authenticate >> sa_authenticate
                    dep_authenticate << svc_authenticate
                    clusterRole << clusterRoleBinding >> sa_authenticate

                    sa_authorize = rbac.ServiceAccount("authorize")
                    dep_authorize = compute.Deployment("authorize")
                    svc_authorize = network.Service("authorize")
                    dep_authorize >> sa_authorize
                    dep_authorize << svc_authorize

                    sa_proxy = rbac.ServiceAccount("proxy")
                    dep_proxy = compute.Deployment("proxy")
                    svc_proxy = network.Service("proxy")
                    dep_proxy >> sa_proxy
                    dep_proxy << svc_proxy

                    sa_cache = rbac.ServiceAccount("cache")
                    dep_cache = compute.Deployment("cache")
                    svc_cache = network.Service("cache")
                    dep_cache >> sa_cache
                    dep_cache << svc_cache

                    dep_authenticate >> auth0


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
