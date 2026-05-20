---
adr: 020
status: ✅ accepted
date: 2024-11-13
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 020 - Database Operators Implementation

## 📝 Context and Problem Statement

Managing databases on Kubernetes requires significant operational effort for high availability and backups. We need a standardized operator-based approach to automate these tasks.

## 💡 Decision

We choose the following operators for our relational databases:
- **PostgreSQL:** CloudNativePG
- **MySQL:** Moco
- **MariaDB:** MariaDB Operator

## 📈 Consequences

- ✅ **Good:** Automated failover and self-healing for database clusters.
- ✅ **Good:** Simplified backup/restore workflows using object storage.
- ✅ **Good:** Consistent management via Kubernetes YAML.
- 🚫 **Bad:** Increased complexity in the Kubernetes control plane.
- 🚫 **Bad:** Dependency on the operator's lifecycle for database upgrades.

## 🔗 References

- [RFC 014 - Cloud-Native Database Strategy](../rfcs/014-database-operators-strategy.md)
