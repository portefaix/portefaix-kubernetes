---
adr: 007
status: ✅ accepted
date: 2023-10-26
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 007 - Gateway API Implementation

## 📝 Context and Problem Statement

The legacy Ingress API is limited by provider-specific annotations and lack of role-based decoupling. We need to move to the standardized Kubernetes Gateway API for better traffic control and portability.

## 💡 Decision

We choose **Traefik** as the primary Gateway API implementation for non-managed environments.

## 📈 Consequences

- ✅ **Good:** Role-based separation (Infra vs. App) for traffic routing.
- ✅ **Good:** Native support for canary deployments and header-based routing without annotations.
- ✅ **Good:** Unified controller for both Ingress and Gateway API during migration.
- 🚫 **Bad:** Requires migrating existing `Ingress` resources to `HTTPRoute`.
- 🚫 **Bad:** Traefik introduces additional CRDs.

## 🔗 References

- [RFC 013 - Gateway API Migration Strategy](../rfcs/013-gateway-api-strategy.md)
- [RFC 003 - Kubernetes Gateway API Adoption](../rfcs/003-k8s-gateway-api.md)
