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

import argparse

import alertmanager
import certmanager_crds
import certmanager
import config
import flux
import flux_crds
import flux_monitoring
import grafana
import kube_state_metrics
import letsencrypt
import node_exporter
import prometheus
import prometheus_operator
import thanos
import velero
import velero_crds


def main(cloud_provider, output, direction):
    alertmanager.architecture(cloud_provider, output, direction)
    certmanager_crds.architecture()
    certmanager.architecture()
    grafana.architecture(cloud_provider, output, direction)
    kube_state_metrics.architecture(cloud_provider, output, direction)
    letsencrypt.architecture()
    node_exporter.architecture(cloud_provider, output, direction)
    prometheus.architecture(cloud_provider, output, direction)
    prometheus_operator.architecture(cloud_provider, output, direction)
    thanos.architecture(cloud_provider, output, direction)
    velero.architecture(cloud_provider, output, direction)
    velero_crds.architecture()
    flux_crds.architecture()
    flux.architecture(cloud_provider, output, direction)
    flux_monitoring.architecture()


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
