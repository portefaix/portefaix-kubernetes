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

from diagrams.k8s import chaos
from diagrams.k8s import controlplane
from diagrams.k8s import ecosystem
from diagrams.k8s import infra
# from diagrams.onprem import auth
from diagrams.onprem import monitoring
from diagrams.onprem import network

import cloud


def kubernetes():
    apiserver = controlplane.API("apiserver")
    kubelet = controlplane.Kubelet("kubelet")
    return apiserver, kubelet


def kubernetes_nodes(size):
    # nodes = []
    # for i in range(size):
    #     nodes.append(infra.Node("node_%s" % i))
    # return nodes
    return [infra.Node("node(s)")]




def setup_monitoring(cloud_provider):
    prometheus_operator = monitoring.PrometheusOperator("operator")
    prometheus = monitoring.Prometheus("prometheus")
    alertmanager = monitoring.Prometheus("alertmanager")
    pushgateway = monitoring.Prometheus("pushgateway")
    node_exporter = monitoring.Prometheus("node_exporter")
    thanos = monitoring.Thanos("thanos")
    kube_state_metrics = cloud.kubernetes(cloud_provider, "kube_state_metrics")
    grafana = monitoring.Grafana("grafana")
    return (
        grafana,
        prometheus_operator,
        prometheus,
        thanos,
        alertmanager,
        pushgateway,
        node_exporter,
        kube_state_metrics,
    )


def setup_chaos():
    litmuschaos = chaos.LitmusChaos("litmus_chaos")
    chaosmesh = chaos.ChaosMesh("chaos_mesh")
    return litmuschaos, chaosmesh


def setup_dns():
    external_dns = ecosystem.ExternalDns("external-dns")
    return external_dns


def setup_identity():
    # oauth2_proxy = auth.Oauth2Proxy("oauth2-proxy")
    # return oauth2_proxy
    pomerium = network.Pomerium("pomerium")
    return pomerium


# def setup_storage():
#     external_dns =
