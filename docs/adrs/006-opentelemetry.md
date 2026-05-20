---
adr: 006
status: ✅ accepted
date: 2024-02-02
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 006 - OpenTelemetry Implementation

## 📝 Context and Problem Statement

We need a unified standard for collecting and exporting metrics, traces, and logs across our multi-cloud infrastructure to avoid vendor lock-in and reduce fragmentation.

## 💡 Decision

We adopt **OpenTelemetry (OTel)** as the universal observability standard for Portefaix.

## 📈 Consequences

- ✅ **Good:** Vendor-neutral instrumentation (instrument once, export anywhere).
- ✅ **Good:** Unified collection for all signals (metrics, traces, logs).
- ✅ **Good:** Deep integration with Kubernetes via the OpenTelemetry Operator.
- 🚫 **Bad:** Requires re-instrumenting existing applications using OTel SDKs.
- 🚫 **Bad:** Overhead of managing OpenTelemetry Collectors (Agents and Gateways).

## 🔗 References

- [RFC 002 - OpenTelemetry Adoption Strategy](../rfcs/002-opentelemetry.md) : Detailed motivation and comparison with fragmented approaches.
