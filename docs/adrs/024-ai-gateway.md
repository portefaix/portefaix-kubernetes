---
adr: 024
status: ✅ accepted
date: 2025-08-21
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 024 - AI Gateway Implementation

## 📝 Context and Problem Statement

To manage the increasing load of AI/ML and LLM traffic, we need a robust gateway to handle routing, security, and observability across multiple LLM providers.

## 💡 Decision

We choose **KGateway** as our primary AI Gateway solution.

## 📈 Consequences

- ✅ **Good:** Mature, production-proven solution built on Envoy.
- ✅ **Good:** Native support for Kubernetes Gateway API.
- ✅ **Good:** Advanced AI features like prompt guards and intelligent failover.
- ✅ **Good:** Strong community and CNCF backing.
- 🚫 **Bad:** Higher operational complexity compared to newer, purpose-built tools.
- 🚀 **Action:** Deploy KGateway and integrate with LLM providers (OpenAI, AWS, etc.).

## 🔗 References

- [RFC 012 - AI Gateway Strategy](../rfcs/012-ai-gateway-strategy.md) : Detailed evaluation of KGateway vs. Envoy AI Gateway.
- [ADR 007 - Kubernetes Gateway API](./007-k8s-gateway-api.md)
