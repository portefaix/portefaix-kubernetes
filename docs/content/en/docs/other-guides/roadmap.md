+++
title = "Roadmap"
description = "The Portefaix Roadmap"
weight = 100

+++

## v1

### Infrastructure

- [x] Development environment</span>
- [x] Terraform code for Google Cloud Platform</span> [ [#1](https://github.com/nlamirault/portefaix/issues/1) ]
- [x] Terraform code for Amazon AWS</span> [ [#2](https://github.com/nlamirault/portefaix/issues/2) ]
- [x] Terraform code for Microsoft Azure</span> [ [#3](https://github.com/nlamirault/portefaix/issues/3) ]

### Core

- [x] Flux v2 bootstrap</span>
- [ ] `WIP` Sops (<i class="fas fa-check"> GKE </i>, <i class="fas fa-check"> EKS </i>, AKS)

### Observability

- [ ] `WIP` Monitoring: Prometheus, Thanos, Alertmanager (<i class="fas fa-check"> GKE </i>, <i class="fas fa-check"> EKS </i>, AKS)
- [ ] `WIP` Logging: Loki, FluentBit, Vector (<i class="fas fa-check"> GKE </i>, EKS, AKS)
- [ ] Tracing: Tempo (GKE, EKS, AKS)

### Networking

- [ ] `WIP` External-DNS, Cert-Manager (<i class="fas fa-check"> GKE </i>, <i class="fas fa-check"> EKS </i>, AKS)
- [ ] `WIP` Oauth2-Proxy (GKE, EKS, AKS)

### Service Mesh

- [ ] `WIP` Open Service Mesh (<i class="fas fa-check"> GKE </i>, EKS, AKS)

### Chaos

- [ ] `WIP` Chaos Mesh (<i class="fas fa-check"> GKE </i>, EKS, AKS)
- [ ] `WIP` Litmus Chaos (<i class="fas fa-check"> GKE </i>, EKS, AKS)

## v2

### Service Mesh Cloud Providers

- [ ] [Traffic Director](https://cloud.google.com/traffic-director/) [ [#8](https://github.com/nlamirault/portefaix/issues/8) ]
- [ ] [AWS App Mesh](https://aws.amazon.com/fr/app-mesh/) [ [#9](https://github.com/nlamirault/portefaix/issues/9) ]
- [ ] [Service Fabric Mesh](https://docs.microsoft.com/en-us/azure/service-fabric-mesh/) [ [#10](https://github.com/nlamirault/portefaix/issues/10) ]

## Backlog

### Cloud providers

- [ ] `WIP` Terraform code for Scaleway</span> [ [#17](https://github.com/nlamirault/portefaix/issues/17) ]
- [ ] `WIP` Terraform code for Digital Ocean</span> [ [#18](https://github.com/nlamirault/portefaix/issues/18) ]

### Secrets Store CSI Driver

- [ ] [GCP Secret manager](https://github.com/GoogleCloudPlatform/secrets-store-csi-driver-provider-gcp) [ [#4](https://github.com/nlamirault/portefaix/issues/4) ]
- [ ] [Amazon Secrets manager](https://github.com/aws/containers-roadmap/issues/895) [ [#5](https://github.com/nlamirault/portefaix/issues/5) ]
- [ ] [Azure Vault](https://github.com/Azure/secrets-store-csi-driver-provider-azure) [ [#6](https://github.com/nlamirault/portefaix/issues/6) ]

### Managing Cloud Services via Kubernetes CRDs

- [ ] [AWS Controllers for Kubernetes (ACK)](https://github.com/aws/aws-controllers-k8s)
- [ ] [Azure Service Operator (for Kubernetes)](https://github.com/Azure/azure-service-operator)
- [ ] [Google Config Connector](https://cloud.google.com/config-connector/docs/overview)
