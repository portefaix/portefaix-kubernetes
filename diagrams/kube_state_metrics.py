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
from diagrams.gcp import compute as compute_gcp
from diagrams.k8s import compute
from diagrams.k8s import network
from diagrams.k8s import storage
from diagrams.k8s import rbac


def k8s_rbac():

    return sa


def architecture(cloud_provider, output, direction):
    with diagrams.Diagram("kube_state_metrics", show=False):
        with diagrams.Cluster("Cloud Platform"):
            with diagrams.Cluster("Kubernetes Cluster"):

                clusterRole = rbac.ClusterRole()
                clusterRoleBinding = rbac.ClusterRoleBinding()

                with diagrams.Cluster("monitoring"):
                    sa = rbac.ServiceAccount()
                    clusterRole << clusterRoleBinding >> sa
                    role = rbac.Role()
                    roleBinding = rbac.RoleBinding()
                    role << roleBinding >> sa

                    svc = network.Service()
                    sm = compute_gcp.KubernetesEngine("servicemonitor")
                    deploy = compute.Deployment()

                    deploy << sa
                    sm >> svc
                    pod = compute.Pod()
                    deploy >> pod
                    svc >> pod


def main():
    architecture()


if __name__ == "__main__":
    main()
