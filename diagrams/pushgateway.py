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
from diagrams.gcp import compute as compute_gcp
from diagrams.k8s import compute
from diagrams.k8s import network
from diagrams.k8s import podconfig
from diagrams.k8s import rbac
from diagrams.k8s import storage


def architecture():
    with diagrams.Diagram("Architecture", show=False):
        with diagrams.Cluster("Cloud Platform"):
            with diagrams.Cluster("Kubernetes Cluster"):

                with diagrams.Cluster("monitoring"):
                    sa = rbac.ServiceAccount()

                    sm = compute_gcp.KubernetesEngine("servicemonitor")
                    svc = network.Service("svc")
                    deploy = compute.Deployment("deploy")
                    deploy << sa
                    pod = compute.Pod("pod")
                    deploy >> pod
                    svc >> pod
                    sm >> svc


def main():
    architecture()


if __name__ == "__main__":
    main()
