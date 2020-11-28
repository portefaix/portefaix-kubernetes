# Alertmanager

=== "Google Cloud Platform"

    ![Prometheus GCP](../../img/alertmanager_gcp.png)

=== "Amazon AWS"

    ![Prometheus AWS](../../img/alertmanager_aws.png)

=== "Microsoft Azure"

    ![Prometheus Azure](../../img/alertmanager_azure.png)

## Description

* Chart : [kube-prometheus-stack](https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack)
* Version: `11.0.4`

## Checks

* Deployment of Alertmanager

```shell
❯ kubectl -n monitoring get alertmanager

```