---
adr: 014
status: ✅ accepted
date: 2024-08-08
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 014 - Internal Developer Portal Implementation

## 📝 Context and Problem Statement

To improve developer experience and service visibility, we need a central portal to catalog services, track infrastructure, and enable developer self-service.

## 💡 Decision

We choose **Port** as our Internal Developer Portal (IDP).

## 📈 Consequences

- ✅ **Good:** Very fast time-to-value with managed SaaS and intuitive UI.
- ✅ **Good:** Flexible blueprint system allows for custom modeling of Portefaix infrastructure.
- ✅ **Good:** Native integrations with our existing toolstack (K8s, Argo CD, Terraform).
- 🚫 **Bad:** Dependency on a SaaS provider (no self-hosted option).
- 🚀 **Action:** Setup Port blueprints and ingest metadata from GitHub and Kubernetes.

## 🔗 References

- [RFC 010 - Internal Developer Portal Strategy](../rfcs/010-idp-strategy.md) : Detailed evaluation of Port vs. Backstage.
