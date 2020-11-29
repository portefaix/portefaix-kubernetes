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


def architecture():
    with diagrams.Diagram("flux-monitoring", show=False):
        with diagrams.Cluster("Cloud Platform"):
            with diagrams.Cluster("Kubernetes Cluster"):
                with diagrams.Cluster("flux-system"):
                    source_pm = compute_gcp.KubernetesEngine("source-controller-podmonitor")
                    # source_pod = compute.Pod("source-controller")
                    # source_pm >> source_pod

                    kustomize_pm = compute_gcp.KubernetesEngine("kustomize-controller-podmonitor")
                    # kustomize_pod = compute.Pod("kustomize-controller")
                    # kustomize_pm >> kustomize_pod

                    helm_pm = compute_gcp.KubernetesEngine("helm-controller-podmonitor")
                    # helm_pod = compute.Pod("helm-controller")
                    # helm_pm >> helm_pod

                    notif_pm = compute_gcp.KubernetesEngine("notification-controller-podmonitor")
                    # notif_pod = compute.Pod("notification-controller")
                    # notif_pm >> notif_pod


def main():
    architecture()


if __name__ == "__main__":
    main()
