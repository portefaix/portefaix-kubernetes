---
adr: 010
status: ❌ superseded
date: 2024-02-02
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 010 - Zero Trust Implementation

> [!CAUTION]
> This ADR has been superseded by [ADR 025 - Zero Trust Kubernetes Access via Cloudflare](./025-zero-trust-kubernetes-access-via-cloudflare.md).

## 📝 Context and Problem Statement

To replace legacy SSH and static `kubeconfig` access, we need a unified identity-centric access model. The goal is to enforce "never trust, always verify" across all clusters, servers, and databases.

## 💡 Decision

We choose **Paralus** as the primary Zero Trust gateway for Kubernetes access management.

## 📈 Consequences

- ✅ **Good:** Centralized audit trails for every `kubectl` action.
- ✅ **Good:** Native integration with OIDC (Ory Kratos) and RBAC (Casbin).
- 🚫 **Bad:** Requires managing an additional infrastructure component (Paralus Dashboard and agents).
- 🚫 **Bad:** Dependency on a search engine (Elasticsearch or Meilisearch) for logs.
- 🚀 **Action:** Existing static credentials must be rotated and deprecated in favor of ephemeral sessions.

## 🔗 References

- [RFC 004 - Zero Trust Strategy](../rfcs/004-zero-trust.md) : Detailed evaluation of Paralus vs. Teleport vs. BastionZero.
