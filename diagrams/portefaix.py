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

import argparse
from urllib import request

import diagrams
from diagrams.aws import network as network_aws
from diagrams.gcp import compute as compute_gcp
from diagrams.gcp import network

# from diagrams.gcp import storage


# from diagrams.k8s import controlplane
# from diagrams.k8s import infra
# from diagrams.onprem import auth
from diagrams.onprem import aggregator
from diagrams.onprem import certificates
from diagrams.onprem import client
from diagrams.onprem import compute
from diagrams.onprem import container
from diagrams.onprem import gitops
from diagrams.onprem import logging
from diagrams.onprem import monitoring
from diagrams.onprem import network as network_onprem
from diagrams.onprem import vcs
from diagrams.saas import alerting
from diagrams.saas import chat
from diagrams.saas import logging as saas_logging
from diagrams import custom

import cloud
import config
import k8s



def setup_container(cloud_provider, kubelet):
    docker = container.Docker("docker")
    if cloud_provider == "gcp":
        gvisor = container.Gvisor("gvisor")
        containerd = container.Containerd("containerd")
        kubelet >> [docker, containerd, gvisor]
    elif cloud_provider == "azure":
        containerd = container.Containerd("containerd")
        kubelet >> [docker, containerd]
    else:
        kubelet >> docker


def architecture(cloud_provider, output, direction):
    with diagrams.Diagram(
        "Portefaix %s" % cloud_provider, show=False, direction="BT", outformat=output
    ):

        ops = client.User("ops")

        with diagrams.Cluster("SAAS"):
            with diagrams.Cluster("DNS"):
                dns = network_aws.Route53("dns")

            with diagrams.Cluster("Chat"):
                slack = chat.Slack("Slack")

            with diagrams.Cluster("Alerting"):
                opsgenie = alerting.Opsgenie("Opsgenie")

            with diagrams.Cluster("Certificates"):
                letsencrypt = certificates.LetsEncrypt("letsencrypt")

            with diagrams.Cluster("Logging"):
                papertrail = saas_logging.Papertrail("papertrail")

        with diagrams.Cluster("Cloud"):

            # with diagrams.Cluster("Services"):

            with diagrams.Cluster("Storage"):
                bucket_metrics = cloud.bucket(cloud_provider, "metrics")
                bucket_logs = cloud.bucket(cloud_provider, "logs")
                bucket_backup = cloud.bucket(cloud_provider, "backup")
                bucket_logs_archive = cloud.bucket(cloud_provider, "logs_archive")

            with diagrams.Cluster("KMS"):
                kms = cloud.kms(cloud_provider, "kms")

            with diagrams.Cluster("Iam"):
                iam = cloud.iam(cloud_provider, "iam")

            with diagrams.Cluster("Network"):
                lb = network.LoadBalancing("lb")
                cloud_dns = network.DNS("cloud-dns")

            with diagrams.Cluster("Compute"):
                vms = []
                for i in range(1):
                    vms.append(cloud.compute(cloud_provider, "vm_%s" % i))
                nodes = k8s.kubernetes_nodes(1)

            with diagrams.Cluster("Kubernetes"):

                with diagrams.Cluster("kube-system"):
                    apiserver, kubelet = k8s.kubernetes()
                    setup_container(cloud_provider, kubelet)

                with diagrams.Cluster("flux-system"):
                    flux = gitops.Flux("flux")
                    flux >> kms
                    # flux >> iam

                with diagrams.Cluster("logging"):
                    loki = logging.Loki("loki")
                    fluentbit = logging.FluentBit("fluentbit")
                    vector = aggregator.Vector("vector")

                with diagrams.Cluster("monitoring"):
                    (
                        grafana,
                        prometheus_operator,
                        prometheus,
                        thanos,
                        alertmanager,
                        pushgateway,
                        node_exporter,
                        kube_state_metrics,
                    ) = k8s.setup_monitoring(cloud_provider)

                with diagrams.Cluster("chaos"):
                    litmuschaos, chaosmesh = k8s.setup_chaos()

                with diagrams.Cluster("dns"):
                    external_dns = k8s.setup_dns()
                    external_dns >> cloud_dns
                    external_dns >> [grafana, prometheus, alertmanager]

                with diagrams.Cluster("identity"):
                    oauth2_proxy = k8s.setup_identity()
                    oauth2_proxy >> [grafana, prometheus, alertmanager]

                with diagrams.Cluster("cert-manager"):
                    cert_manager = certificates.CertManager("cert-manager")
                    cert_manager >> [grafana, prometheus, alertmanager]
                    cert_manager >> letsencrypt

                with diagrams.Cluster("Ingress-Controllers"):
                    ingress = network_onprem.Nginx("nginx")

                

                # with diagrams.Cluster("storage"):
                #     velero = setup_storage()
                

                prometheus_operator >> [prometheus, alertmanager]

                prometheus << grafana
                # prometheus >> iam

                alertmanager >> [slack, opsgenie]
                # alertmanager >> iam

                # [apiserver, kubelet] << kube_state_metrics
                kube_state_metrics >> [apiserver, kubelet]

                node_exporter >> nodes

                [pushgateway, kube_state_metrics, node_exporter] << prometheus
                alertmanager >> prometheus
                prometheus >> vms

                thanos >> prometheus
                [thanos, prometheus] >> bucket_metrics
                # thanos >> iam

                thanos << grafana

                fluentbit >> nodes
                fluentbit >> loki
                bucket_logs << loki
                loki << grafana

                # vector >> nodes
                vector >> bucket_logs_archive
                vector >> papertrail

                


        # [grafana, prometheus, thanos, alertmanager] << ingress
        oauth2_proxy << ingress << lb << dns

        opsgenie >> [slack, ops]
        [grafana, slack] << ops

        iam >> [flux, prometheus, alertmanager, thanos, loki, external_dns]



def main(cloud_provider, output, direction):
    architecture(cloud_provider, output, direction)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-o",
        "--output",
        type=str,
        choices=config.outformats,
        default="png",
        help="Output format",
    )
    parser.add_argument(
        "-d",
        "--direction",
        type=str,
        choices=config.directions,
        default="LR",
        help="Diagram direction",
    )
    parser.add_argument(
        "-c",
        "--cloud",
        type=str,
        choices=config.cloud_providers,
        # default="gcp",
        help="Cloud provider",
    )
    args = parser.parse_args()
    main(args.cloud, args.output, args.direction)
