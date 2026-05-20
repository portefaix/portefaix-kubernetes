---
adr: 008
status: ✅ accepted
date: 2023-11-01
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 008 - Security Observability Implementation

## 📝 Context and Problem Statement

We need kernel-level security visibility (file access, network activity, process execution) to detect suspicious behavior within our Kubernetes clusters.

## 💡 Decision

We choose **Falco** as our primary security observability and runtime security tool.

## 📈 Consequences

- ✅ **Good:** Access to a vast ecosystem of security rules and integrations (Falcosidekick).
- ✅ **Good:** eBPF-based monitoring provides deep visibility with minimal overhead.
- ✅ **Good:** Integrated with our existing Prometheus/Loki stack for alerting.
- 🚫 **Bad:** Requires specific kernel support and node-level privileged access.
- 🚀 **Action:** Deploy Falco as a DaemonSet across all clusters.

## 🔗 References

- [RFC 006 - Security Observability Strategy](../rfcs/006-security-observability.md) : Detailed evaluation of eBPF tools (Falco, Tetragon, Tracee).
