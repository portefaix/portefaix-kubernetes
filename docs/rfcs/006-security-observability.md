---
rfc: 006
status: ✅ accepted
date: 2023-10-15
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# RFC 006 - Security Observability Strategy

## 1. 📝 Summary

This RFC proposes a strategy for implementing security observability across Portefaix infrastructure using eBPF technology. The goal is to gain deep visibility into kernel-level activities (file access, network activity, privilege escalation) to detect and respond to security threats in real-time.

## 2. 🎯 Motivation

### Current State
Currently, our observability (RFC 002) focuses on application and infrastructure performance (metrics, traces, logs). We lack dedicated, deep security auditing at the kernel level.

### Problems
- **Blind Spots:** No visibility into namespace escapes, unauthorized file access, or suspicious system calls.
- **Delayed Detection:** Security incidents might only be detected after an application-level impact occurs.
- **Compliance:** Lack of detailed audit trails for regulatory requirements.

## 3. 📖 Guide-level Explanation

We will leverage **eBPF (Extended Berkeley Packet Filter)** to intercept system calls and kernel events without modifying application code. This allows us to:
- Monitor process execution and privilege changes.
- Track network activity at the protocol level (HTTP, DNS, TLS).
- Alert on suspicious behavior based on a set of predefined and custom security rules.

## 4. 🔬 Reference-level Explanation

### Technical Requirements
- Native eBPF support in the underlying Linux kernel (Talos/Flatcar).
- Low overhead on application performance.
- Integration with existing alerting pipelines (Loki, Prometheus, Slack).
- Support for custom security rules (YAML-based).

## 5. 🔍 Considered Options

### Option 1: Falco
- **Overview:** The de-facto standard for cloud-native runtime security (CNCF Graduated).
- **Pros:** Massive library of predefined rules, mature ecosystem (Falcosidekick), excellent integration with Grafana/Loki.
- **Cons:** Configuration can be verbose.

### Option 2: Tetragon
- **Overview:** Part of the Cilium ecosystem, focused on security observability and enforcement.
- **Pros:** Deep integration with Cilium CNI, powerful filtering at the source.
- **Cons:** Dashboards and observability tooling are less mature than Falco's.

### Option 3: Tracee
- **Overview:** Aqua Security's eBPF-based security tracing tool.
- **Pros:** High-fidelity event stream.
- **Cons:** Smaller community and more complex setup compared to Falco.

## 6. ⚠️ Drawbacks
- **Kernel Dependency:** Requires specific kernel versions and configurations.
- **Resource Usage:** eBPF programs and collectors consume CPU/Memory on every node.
- **Alert Noise:** Requires fine-tuning of rules to avoid alert fatigue.

## 7. 🚀 Next Steps
1. Deploy Falco on a pilot cluster.
2. Integrate Falco events into Loki and Grafana.
3. Define a baseline set of security rules for Portefaix.
