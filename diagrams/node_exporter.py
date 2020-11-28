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
from diagrams.k8s import storage
from diagrams.k8s import rbac

def k8s_rbac():
    sa = rbac.ServiceAccount()
    # clusterRole = rbac.ClusterRole()
    # clusterRoleBinding = rbac.ClusterRoleBinding()
    # clusterRole << clusterRoleBinding >> sa
    # role = rbac.Role()
    # roleBinding = rbac.RoleBinding()
    # role << roleBinding >> sa
    return sa


def architecture(cloud_provider, output, direction):
    with diagrams.Diagram("node_exporter", show=False):
        with diagrams.Cluster("Cloud Platform"):
            with diagrams.Cluster("Kubernetes Cluster"):

                sa = k8s_rbac()

                with diagrams.Cluster("Monitoring namespace"):
                    svc = network.Service("svc")
                    ds = compute.DaemonSet("ds")

                    ds << sa

                    apps = []
                    for _ in range(3):
                        pod = compute.Pod("pod")
                        pod - ds
                        apps.append(svc >> pod)


def main():
    architecture()

if __name__ == "__main__":
    main()