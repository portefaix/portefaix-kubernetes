---
adr: 016
status: ✅ accepted
date: 2024-09-14
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 016 - Immutable Operating System Implementation

## 📝 Context and Problem Statement

To enhance security, consistency, and automation of our Kubernetes nodes, we need an immutable, minimal, and container-optimized operating system.

## 💡 Decision

We choose **Talos** as our primary operating system for Kubernetes nodes.

## 📈 Consequences

- ✅ **Good:** Reduced attack surface (no shell, no SSH, no package manager).
- ✅ **Good:** Fully declarative configuration via YAML.
- ✅ **Good:** API-driven management simplifies automation and cluster lifecycle.
- 🚫 **Bad:** Operational shift: no traditional SSH access; requires learning `talosctl`.
- 🚫 **Bad:** Immutable root filesystem requires careful planning for persistent storage or custom configurations.
- 🚀 **Action:** Transition Homelab and cloud clusters to Talos-based nodes.

## 🔗 References

- [RFC 011 - Immutable Operating System Strategy](../rfcs/011-immutable-os-strategy.md) : Detailed evaluation of Talos vs. Flatcar vs. Kairos vs. Bottlerocket.
