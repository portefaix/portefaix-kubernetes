---
adr: 012
status: ✅ accepted
date: 2024-04-22
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 012 - OIDC Provider Implementation

## 📝 Context and Problem Statement

We need a lightweight connector to federate identity from our IdP to Kubernetes clusters and internal tools using the OIDC protocol.

## 💡 Decision

We choose **Dex** as our federated OIDC provider.

## 📈 Consequences

- ✅ **Good:** Lightweight and proven solution (CNCF Sandbox).
- ✅ **Good:** Seamless integration with existing tools like Argo CD.
- ✅ **Good:** Supports multiple upstream connectors.
- 🚫 **Bad:** Static configuration model (YAML files).

## 🔗 References

- [RFC 009 - Identity & Access Management Strategy](../rfcs/009-iam-strategy.md) : Detailed evaluation of Dex vs. Hydra.
