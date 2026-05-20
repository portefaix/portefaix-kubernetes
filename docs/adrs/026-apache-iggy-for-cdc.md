---
adr: 026
status: ✅ accepted
date: 2026-05-05
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 026 - Apache Iggy for CDC

## 📝 Context and Problem Statement

Following the initial choice of Olake for Change Data Capture (ADR 023), further investigation revealed that Olake requires **Temporal** for orchestration and **NFS** for some storage components. These dependencies introduce significant operational overhead and infrastructure requirements that we want to avoid in the Portefaix ecosystem.

We need a high-performance, lightweight, and cloud-native CDC solution that aligns with our goal of simplicity and efficiency.

## 💡 Decision

We choose **Apache Iggy** as our primary Change Data Capture (CDC) and message streaming engine.

Apache Iggy will be used along with its **Connectors Runtime** to ingest real-time changes from our databases (Postgres, MySQL) and stream them to downstream consumers.

## 📈 Consequences

- ✅ **Good:** Extreme performance (millions of messages per second) with microsecond-level latency.
- ✅ **Good:** Written in Rust, providing memory safety and high efficiency without JVM overhead.
- ✅ **Good:** Leverages modern Linux `io_uring` for optimal I/O.
- ✅ **Good:** Minimal operational footprint: single binary deployment with no external dependencies like Temporal or NFS.
- ✅ **Good:** Native support for multiple protocols (QUIC, TCP, etc.).
- 🚫 **Bad:** Project is currently in the Apache Incubator, meaning some enterprise features (like mature clustering) are still evolving.
- 🚫 **Bad:** Custom protocol and SDKs required (not Kafka-compatible).

## 🔗 References

- [RFC 016 - Change Data Capture (CDC) Strategy](../rfcs/016-cdc-strategy.md)
- [ADR 023 - Change Data Capture Implementation](023-cdc.md) (Superseded)
- [Apache Iggy Official Site](https://iggy.rs/)
