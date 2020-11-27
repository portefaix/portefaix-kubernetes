{
  _config+:: {

    // Grafana dashboard IDs are necessary for stable links for dashboards
    grafanaDashboardIDs: {
      'k8s-cluster-overview.json': '1gBgaexoVZ4TpBNAt2eGRsc4LNjNhdjcZd6cqU6S',
    },

    // Config for the Grafana dashboards in the Kubernetes Mixin
    grafanaK8s: {
      dashboardNamePrefix: 'Portefaix / ',
      dashboardTags: ['portefaix-mixin'],

      // For links between grafana dashboards, you need to tell us if your grafana
      // servers under some non-root path.
      linkPrefix: '.',

      // The default refresh time for all dashboards
      refresh: '10s',
      // The default minimum time interval
      minimumTimeInterval: '1m',
    },
  },
}
