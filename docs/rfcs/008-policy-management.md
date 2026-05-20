---
rfc: 008
status: ✅ accepted
date: 2024-11-01
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# RFC 008 - Policy Management Strategy

## 1. 📝 Summary

This RFC proposes a unified strategy for policy enforcement within Portefaix Kubernetes clusters. The goal is to ensure security, compliance, resource efficiency, and reliability by automatically validating or mutating resources before they are admitted to the cluster.

## 2. 🎯 Motivation

### Current State
As Portefaix grows, manually reviewing every Kubernetes manifest for security and operational best practices is becoming impossible.

### Problems
- **Security Risks:** Risk of privileged containers, unauthorized image registries, or missing network policies.
- **Resource Exhaustion:** Workloads without resource requests/limits can destabilize nodes.
- **Inconsistency:** Different teams using different labels, annotations, and configurations.
- **Compliance:** Need to enforce specific constraints for regulatory standards (GDPR, etc.).

## 3. 📖 Guide-level Explanation

We will implement **Policy-as-Code** to provide automated guardrails for developers. Policies will:
- **Validate:** Reject resources that violate security or operational rules.
- **Mutate:** Automatically add required labels or annotations to resources.
- **Audit:** Report on existing resources that do not comply with current policies.

## 4. 🔬 Reference-level Explanation

### Technical Requirements
- Native integration with Kubernetes admission controllers.
- Support for **CEL (Common Expression Language)** for performant validation.
- Minimal operational overhead (avoiding complex external languages if possible).
- Support for standard security benchmarks (e.g., Pod Security Standards).

## 5. 🔍 Considered Options

### Option 1: Open Policy Agent (OPA) / Gatekeeper
- **Overview:** General-purpose policy engine using the Rego language.
- **Pros:** Industry standard, extremely expressive, mature ecosystem.
- **Cons:** Steep learning curve for Rego, high operational complexity.

### Option 2: Kyverno
- **Overview:** Kubernetes-native policy engine using YAML.
- **Pros:** No new language to learn, very popular in the K8s community, supports mutation and generation.
- **Cons:** Can become complex for very sophisticated logic.

### Option 3: Kubewarden
- **Overview:** Policy engine using WebAssembly (Wasm).
- **Pros:** Write policies in any language (Go, Rust), very high performance.
- **Cons:** Smaller community, requires Wasm knowledge.

### Option 4: Kubernetes Validating Admission Policy (VAP)
- **Overview:** Native Kubernetes feature using CEL for validation.
- **Pros:** Zero external dependencies, extremely fast, built into K8s (v1.30+), minimal overhead.
- **Cons:** No mutation support (validation only), newer feature with fewer community-contributed policy libraries.

## 6. ⚠️ Drawbacks
- Policy management can introduce friction if rules are too restrictive.
- Need to manage "exceptions" for specific workloads.
- Potential performance impact on the Kubernetes API server if many complex policies are active.

## 7. 🚀 Next Steps
1. Enable Validating Admission Policy feature in Portefaix clusters.
2. Implement core Pod Security Standards using VAP.
3. Establish a workflow for policy exceptions.
