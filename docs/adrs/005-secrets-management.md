---
adr: 005
status: ✅ accepted
date: 2023-08-18
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 005 - Secrets Management Implementation

## 📝 Context and Problem Statement

Manual secret management using Kubeseal is non-scalable and prone to errors. We need an automated way to sync secrets from various Cloud Secret Managers (AWS, GCP, Azure, Scaleway, Vault) into Kubernetes.

## 💡 Decision

We have decided to use **External Secrets Operator (ESO)** as our primary solution for secret synchronization.

## 📈 Consequences

- ✅ **Good:** Full automation from Cloud Provider to K8s Secrets.
- ✅ **Good:** Multi-cloud support with a single operator.
- ✅ **Good:** Native integration with GitOps (Argo CD).
- ⚠️ **Neutral:** Introduction of new CRDs (`ExternalSecret`, `SecretStore`, `ClusterSecretStore`).
- 🚫 **Bad:** Dependency on Cloud Provider API availability.

## 🔗 References

- [RFC 005 - Secrets Management Strategy](../rfcs/005-secrets-management.md) : Detailed evaluation of ESO vs. CSI Driver vs. VSO.
- [RFC 001 - Secrets Management Strategy](../rfcs/001-secrets-management.md)
