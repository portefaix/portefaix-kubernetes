---
rfc: 015
status: ✅ accepted
date: 2024-11-01
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# RFC 015 - WebAssembly (Wasm) Integration Strategy

## 1. 📝 Summary

This RFC proposes the integration of WebAssembly (Wasm) into the Portefaix infrastructure. The goal is to provide a highly portable, secure, and performant execution environment for serverless workloads, edge computing, and sidecar components.

## 2. 🎯 Motivation

### Current State
Portefaix currently relies entirely on Linux containers (Docker/Containerd) for all workloads. While powerful, containers have overhead in terms of startup time, image size, and resource isolation.

### Problems
- **Startup Latency:** Container cold starts can be slow for ephemeral or serverless tasks.
- **Resource Usage:** Each container requires a full root filesystem and various OS libraries.
- **Security Isolation:** While containers use namespaces and cgroups, Wasm provides a more robust, hardware-level sandbox.
- **Multi-Architecture:** Managing multi-arch container images (amd64, arm64) adds complexity.

## 3. 📖 Guide-level Explanation

WebAssembly (Wasm) allows us to run code in a lightweight, sandboxed virtual machine.
- **Portable:** The same `.wasm` binary runs on any architecture.
- **Secure:** Code is isolated from the host by default.
- **Fast:** Near-native performance with sub-millisecond startup times.

We will integrate Wasm into Portefaix to support:
1. **Serverless Functions:** High-density, fast-starting workloads.
2. **Kubernetes Integration:** Running Wasm side-by-side with containers.

## 4. 🔬 Reference-level Explanation

### Technical Requirements
- Support for **WASI (WebAssembly System Interface)** for system-level access.
- High-performance execution (JIT/AOT).
- Integration with Kubernetes via a dedicated runtime or framework (e.g., wasmCloud).
- Support for modern languages (Rust, Go, Zig).

## 5. 🔍 Considered Options

### Wasm Runtimes
- **Wasmer:** High performance with both JIT and AOT support, very flexible.
- **Wasmtime:** Backed by the Bytecode Alliance, focused on security and speed, excellent WASI support.
- **WasmEdge:** Optimized for cloud-native and edge computing, low memory footprint.

### Orchestration
- **wasmCloud:** A distributed application platform for running Wasm actors. It provides a higher-level abstraction than a raw runtime.

## 6. Decision Outcome
- **Runtime:** **Wasmtime** (selected for its maturity and security focus).
- **Framework:** **wasmCloud** (for higher-level orchestration on Kubernetes).

## 7. 🚀 Next Steps
1. Deploy a wasmCloud cluster within Portefaix.
2. Develop a pilot "Actor" in Rust to test Wasm execution.
3. Integrate Wasm metrics into our OTel pipeline (RFC 002).
