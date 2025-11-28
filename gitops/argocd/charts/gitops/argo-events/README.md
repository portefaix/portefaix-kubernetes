# argo-events

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 1.12.0](https://img.shields.io/badge/AppVersion-1.12.0-informational?style=flat-square)

## Requirements

| Repository                       | Name        | Version |
| -------------------------------- | ----------- | ------- |
| oci://ghcr.io/argoproj/argo-helm | argo-events | 2.4.4   |

## Values

| Key                                                                                     | Type   | Default                     | Description |
| --------------------------------------------------------------------------------------- | ------ | --------------------------- | ----------- |
| argo-events.controller.metrics.enabled                                                  | bool   | `true`                      |             |
| argo-events.controller.metrics.serviceMonitor.additionalLabels."prometheus.io/operator" | string | `"portefaix"`               |             |
| argo-events.controller.metrics.serviceMonitor.enabled                                   | bool   | `true`                      |             |
| argo-events.global.additionalLabels."portefaix.xyz/version"                             | string | `"v0.54.0"`                 |             |
| eventbus.jetstream.exotic.data.accessSecret.key                                         | string | `"secret-key"`              |             |
| eventbus.jetstream.exotic.data.accessSecret.name                                        | string | `"my-secret-name"`          |             |
| eventbus.jetstream.exotic.data.streamConfig                                             | string | `""`                        |             |
| eventbus.jetstream.exotic.data.url                                                      | string | `"nats://xxxxx:xxx"`        |             |
| eventbus.jetstream.exotic.enabled                                                       | bool   | `false`                     |             |
| eventbus.jetstream.exotic.name                                                          | string | `"core"`                    |             |
| eventbus.jetstream.native.enabled                                                       | bool   | `false`                     |             |
| eventbus.jetstream.native.name                                                          | string | `"core"`                    |             |
| eventbus.jetstream.native.replicas                                                      | int    | `3`                         |             |
| eventbus.jetstream.native.version                                                       | string | `"latest"`                  |             |
| eventbus.nats.exotic.data.accessSecret.key                                              | string | `"secret-key"`              |             |
| eventbus.nats.exotic.data.accessSecret.name                                             | string | `"my-secret-name"`          |             |
| eventbus.nats.exotic.data.auth                                                          | string | `"token"`                   |             |
| eventbus.nats.exotic.data.clusterID                                                     | string | `"cluster-id"`              |             |
| eventbus.nats.exotic.data.url                                                           | string | `"nats://xxxxx:xxx"`        |             |
| eventbus.nats.exotic.enabled                                                            | bool   | `false`                     |             |
| eventbus.nats.exotic.name                                                               | string | `"core"`                    |             |
| eventbus.nats.native.auth                                                               | string | `"none"`                    |             |
| eventbus.nats.native.enabled                                                            | bool   | `true`                      |             |
| eventbus.nats.native.name                                                               | string | `"core"`                    |             |
| eventbus.nats.native.replicas                                                           | int    | `3`                         |             |
| eventsource.publicIp.enabled                                                            | bool   | `true`                      |             |
| eventsource.publicIp.eventBusName                                                       | string | `"nats-native-core"`        |             |
| eventsource.publicIp.name                                                               | string | `"public-ip"`               |             |
| eventsource.serviceAccountName                                                          | string | `"argo-event-core"`         |             |
| eventsource.workflows.enabled                                                           | bool   | `true`                      |             |
| eventsource.workflows.eventBusName                                                      | string | `"nats-native-core"`        |             |
| eventsource.workflows.name                                                              | string | `"argo-workflows"`          |             |
| sensor.log.dependencies[0].eventName                                                    | string | `"every-morning-public-ip"` |             |
| sensor.log.dependencies[0].eventSourceName                                              | string | `"public-ip"`               |             |
| sensor.log.dependencies[0].name                                                         | string | `"dep-public-ip"`           |             |
| sensor.log.enabled                                                                      | bool   | `true`                      |             |
| sensor.log.eventBusName                                                                 | string | `"nats-native-core"`        |             |
| sensor.log.name                                                                         | string | `"debug-log"`               |             |
| timezone                                                                                | string | `"Europe/Paris"`            |             |

---

Autogenerated from chart metadata using
[helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
