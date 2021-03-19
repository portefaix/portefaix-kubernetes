#!/usr/bin/python3

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

import diagrams
from diagrams.k8s import compute
from diagrams.k8s import network
from diagrams.k8s import storage
from diagrams.k8s import rbac

import cloud


def cloud_provider_resources(cloud_provider):
    iam = cloud.iam(cloud_provider, "iam")
    return iam


def architecture(cloud_provider, output, direction):
    with diagrams.Diagram("node_exporter_%s" % cloud_provider, show=False):
        with diagrams.Cluster("Cloud Platform"):
            iam = cloud_provider_resources(cloud_provider)

            with diagrams.Cluster("Kubernetes Cluster"):

                with diagrams.Cluster("Monitoring namespace"):
                    sa = rbac.ServiceAccount()
                    svc = network.Service("svc")
                    ds = compute.DaemonSet("ds")

                    ds << sa
                    pod = compute.Pod("pod")
                    pod - ds
                    svc >> pod

                    sa >> iam

def main():
    architecture()

if __name__ == "__main__":
    main()
