// Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// local grafana = import 'grafonnet/grafana.libsonnet';
local grafana = import 'github.com/grafana/grafonnet-lib/grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local prometheus = grafana.prometheus;
local graphPanel = grafana.graphPanel;

{
  _config+:: {
  },
  grafanaDashboards+:: {
    'portefaix-k8s-overview.json':
      dashboard.new(
        'Cluster Overview',
        '%(dashboardNamePrefix)sCluster Overview' % $._config.grafanaK8s,
        tags=($._config.grafanaK8s.dashboardTags),
        time_from='now-1h',
      ).addTemplate(
        {
          current: {
            text: 'Prometheus',
            value: 'Prometheus',
          },
          hide: 0,
          label: null,
          name: 'datasource',
          options: [],
          query: 'prometheus',
          refresh: 1,
          regex: '',
          type: 'datasource',
        },
      )
      .addRow(
        row.new()
        .addPanel(
          graphPanel.new(
            'Graph',
            datasource='$datasource',
            span=6,
            format='short',
          )
        )
      )
      + { refresh: $._config.grafanaK8s.refresh },
  },
}