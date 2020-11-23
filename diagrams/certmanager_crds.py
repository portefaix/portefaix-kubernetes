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
from diagrams.k8s import controlplane
from diagrams.k8s import others


def architecture():
    with diagrams.Diagram("cert-manager-crds", show=False, direction="TB"):
        with diagrams.Cluster("Google Cloud Platform"):
            with diagrams.Cluster("Kubernetes Cluster"):
                apiserver = controlplane.APIServer("apiserver")
                crds = [
                    others.CRD("certificaterequest"),
                    others.CRD("certificate"),
                    others.CRD("clusterissuer"),
                    others.CRD("issuer"),
                    others.CRD("order"),
                ]
                apiserver >> crds
