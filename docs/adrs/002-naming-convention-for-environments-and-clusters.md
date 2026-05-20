---
adr: 002
status: ✅ proposed
deciders:
date: 2023-08-18
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 002: Naming convention for environments and clusters

## 📝 Context and Problem Statement

As we are building our platform on Public Cloud providers we have already found the need to build quite a few environments or clusters.

1. we want to differentiate between clusters that have real usage on them and those that are for internal testing purposes
2. we do not want to differentiate cluster by function (e.g. "perf-test", "sandbox") or status ("non-production").
3. we want to find which cloud provider is used reading the name of the environment or the cluster

To make this easier we propose having a naming scheme that makes it easy to understand.

## 💡 Decision Outcome

We will name all clusters with the following naming scheme:

- `portefaix-<cloud provider>-<environment>` for the kubernetes clusters
- available environments are: `dev`, `staging`, `prod`, `sandbox` and `homelab`

## 📈 Consequences

1. Any new clusters that are built use this naming scheme
2. Any environment must use this naming
