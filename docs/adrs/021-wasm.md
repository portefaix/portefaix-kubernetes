---
adr: 021
status: ✅ accepted
date: 2024-11-19
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 021 - WebAssembly Implementation

## 📝 Context and Problem Statement

For edge computing and high-density serverless workloads, we need a lightweight, secure, and portable runtime beyond traditional Linux containers.

## 💡 Decision

We choose **Wasmtime** as our primary WebAssembly runtime, integrated via the **wasmCloud** platform.

## 📈 Consequences

- ✅ **Good:** Extremely fast startup times and low resource overhead.
- ✅ **Good:** Hardware-level sandboxing for improved security.
- ✅ **Good:** "Write once, run anywhere" portability across architectures.
- 🚫 **Bad:** New execution model to learn and manage.
- 🚫 **Bad:** Ecosystem for server-side Wasm is still evolving compared to containers.

## 🔗 References

- [RFC 015 - WebAssembly (Wasm) Integration Strategy](../rfcs/015-wasm-strategy.md)
