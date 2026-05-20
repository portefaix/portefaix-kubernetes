---
adr: 004
status: ✅ proposed
deciders:
date: 2023-08-18
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 004: Keeping Terraform modules up to date

## 📝 Context and Problem Statement

We maintain a lot of [terraform modules] which teams use to manage AWS
resources for their namespaces.

Not using fixed versions prevents continuous infrastructure deployment. You can't be sure of the idempotent side.

## 💡 Decision

We have decided to ensure that all Terraform modules are always pinned and use the latest version of each module.
each module.

## 📈 Consequences

- Configure Renovate to check Terraform modules versions
