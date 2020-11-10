# Roadmap

## v1

### Infrastructure

[= 30% "30%"]

Tasks

- [x] Development environment</span>
- [x] Terraform code for Google Cloud Platform</span> [ [#1](https://github.com/nlamirault/portefaix-lab/issues/1) ]
- [ ] Terraform code for Amazon AWS</span> [ [#2](https://github.com/nlamirault/portefaix-lab/issues/2) ]
- [ ] Terraform code for Microsoft Azure</span> [ [#3](https://github.com/nlamirault/portefaix-lab/issues/3) ]

### Kubernetes

[= 25% "25%"]

#### Core

- [x] Flux v2 bootstrap</span>
- [x] Sealed secrets

#### Observability

- [ ] Monitoring: Prometheus, Thanos, Alertmanager, ...
- [ ] Logging: Loki, FluentBit
- [ ] Tracing: Tempo

#### Service Mesh

- [ ] Open Service Mesh

#### Chaos

- [ ] Chaos Mesh
- [ ] Litmus Chaos

## v2

[= 0% "0%"]

- [ ] Do not store secrets in Git: [Secrets Store CSI Driver](https://github.com/kubernetes-sigs/secrets-store-csi-driver)
  - [ ] [GCP Secret manager](https://github.com/GoogleCloudPlatform/secrets-store-csi-driver-provider-gcp) [ [#4](https://github.com/nlamirault/portefaix-lab/issues/4) ]
  - [ ] [Amazon Secrets manager](https://github.com/aws/containers-roadmap/issues/895) [ [#5](https://github.com/nlamirault/portefaix-lab/issues/5) ]
  - [ ] [Azure Vault](https://github.com/Azure/secrets-store-csi-driver-provider-azure) [ [#6](https://github.com/nlamirault/portefaix-lab/issues/6) ]

<!--
- <span class="check-bullet">:material-check-bold:</span> Foo bar
- <span class="close-bullet">:material-close-bold:</span> Foo ba
 -->
