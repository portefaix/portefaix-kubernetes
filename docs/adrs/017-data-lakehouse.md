---
adr: 017
status: ✅ accepted
date: 2024-09-23
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 017 - Data Lakehouse Implementation

## 📝 Context and Problem Statement

We need a unified, high-performance query engine to access data across disparate sources (PostgreSQL, MySQL, S3/MinIO) with support for modern table formats and vector search.

## 💡 Decision

We choose **StarRocks** as our primary Data Lakehouse query engine.

## 📈 Consequences

- ✅ **Good:** Extremely high performance via a native vectorized engine.
- ✅ **Good:** Support for federated queries across multiple data sources.
- ✅ **Good:** Native support for Apache Iceberg and Apache Parquet.
- ✅ **Good:** Built-in vector search capabilities for AI applications.
- 🚫 **Bad:** High memory and CPU requirements for the cluster nodes.
- 🚫 **Bad:** New component to manage and monitor.

## 🔗 References

- [RFC 007 - Data Lakehouse Strategy](../rfcs/007-data-lakehouse.md) : Detailed evaluation of StarRocks vs. Trino vs. Dremio.
