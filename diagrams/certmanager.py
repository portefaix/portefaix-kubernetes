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


def k8s_rbac():
    sa_cainjector = rbac.ServiceAccount("cainjector")
    role_cainjector = rbac.Role()
    roleBinding_cainjector = rbac.RoleBinding()
    role_cainjector << roleBinding_cainjector >> sa_cainjector
    clusterRole_cainjector = rbac.ClusterRole()
    clusterRoleBinding_cainjector = rbac.ClusterRoleBinding()
    clusterRole_cainjector << clusterRoleBinding_cainjector >> sa_cainjector

    sa_webhook = rbac.ServiceAccount("webhook")
    role_webhook = rbac.Role()
    roleBinding_webhook = rbac.RoleBinding()
    role_webhook << roleBinding_webhook >> sa_webhook
    clusterRole_webhook = rbac.ClusterRole()
    clusterRoleBinding_webhook = rbac.ClusterRoleBinding()
    clusterRole_webhook << clusterRoleBinding_webhook >> sa_webhook

    sa_certmanager = rbac.ServiceAccount("certmanager")
    role_certmanager = rbac.Role()
    roleBinding_certmanager = rbac.RoleBinding()
    role_certmanager << roleBinding_certmanager >> sa_certmanager
    clusterRole_certmanager = rbac.ClusterRole()
    clusterRoleBinding_certmanager = rbac.ClusterRoleBinding()
    clusterRole_certmanager << clusterRoleBinding_certmanager >> sa_certmanager

    return sa_certmanager, sa_cainjector, sa_webhook


def architecture():
    with diagrams.Diagram("cert-manager", show=False, direction="TB"):
        with diagrams.Cluster("Cloud Platform"):
            with diagrams.Cluster("Kubernetes Cluster"):

                sa_certmanager, sa_cainjector, sa_webhook = k8s_rbac()

                with diagrams.Cluster("cert-manager"):
                    deploy_certmanager = compute.Deployment("certmanager")
                    svc_certmanager = network.Service()
                    svc_certmanager << deploy_certmanager << sa_certmanager

                    deploy_cainjector = compute.Deployment("cainjector")
                    svc_cainjector = network.Service()
                    svc_cainjector << deploy_cainjector << sa_cainjector

                    deploy_webhook = compute.Deployment("webhook")
                    svc_webhook = network.Service()
                    svc_webhook << deploy_webhook << sa_webhook

                    #  TODO:
                    # mutatingWebhookConfiguration
                    # validatingWebhookConfiguration
