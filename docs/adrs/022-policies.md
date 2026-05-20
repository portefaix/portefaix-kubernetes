---
adr: 022
status: ✅ accepted
date: 2024-11-21
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 022 - Policy Management Implementation

## 📝 Context and Problem Statement

To ensure security, compliance, and reliability, we need an automated way to enforce policies on Kubernetes resources. We seek a high-performance solution with minimal operational overhead.

## 💡 Decision

We choose the native **Kubernetes Validating Admission Policy (VAP)** as our primary mechanism for policy enforcement.

## 📈 Consequences

- ✅ **Good:** Native feature with zero external dependencies (no extra controllers to manage).
- ✅ **Good:** Extremely high performance using the Common Expression Language (CEL).
- ✅ **Good:** Simplified operations and integration into standard K8s workflows.
- 🚫 **Bad:** No support for resource mutation (requires standard K8s mutation or external tools if mutation becomes mandatory).
- 🚫 **Bad:** Limited to Kubernetes v1.30+ for stable features.

## 🔗 References

- [RFC 008 - Policy Management Strategy](../rfcs/008-policy-management.md) : Detailed evaluation of VAP vs. OPA vs. Kyverno vs. Kubewarden.
