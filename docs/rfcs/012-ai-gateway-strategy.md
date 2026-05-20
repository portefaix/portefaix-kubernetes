---
rfc: 012
status: ✅ accepted
date: 2025-08-01
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# RFC 012 - AI Gateway Strategy

## 1. 📝 Summary

This RFC proposes the implementation of an **AI Gateway** to manage, secure, and observe traffic to Large Language Models (LLMs) and other AI services. The goal is to provide a unified entry point for all AI-related API calls, enabling centralized governance, rate limiting, and provider abstraction.

## 2. 🎯 Motivation

### Current State
Applications are increasingly integrating with LLM providers (OpenAI, Anthropic, AWS Bedrock). Currently, these integrations are handled individually by each application, leading to fragmented management.

### Problems
- **Credential Proliferation:** API keys are scattered across multiple application secrets.
- **Lack of Governance:** No central way to enforce prompt guards, cost limits, or security policies.
- **Observability Gaps:** Difficult to track total token usage, costs, and latency across all AI workloads.
- **Provider Lock-in:** Hard to switch or failover between LLM providers without code changes.
- **Security:** No centralized filtering for sensitive data in prompts or responses.

## 3. 📖 Guide-level Explanation

The AI Gateway acts as an intelligent proxy between our applications and LLM providers.
1. **Abstraction:** Applications call the local AI Gateway instead of provider APIs directly.
2. **Security:** The gateway enforces prompt guards and PII (Personally Identifiable Information) filtering.
3. **Control:** Centralized rate limiting and token budgeting.
4. **Resiliency:** Automated failover between different providers or models if one is unavailable.

## 4. 🔬 Reference-level Explanation

### Technical Requirements
- Native support for the **Kubernetes Gateway API**.
- Integration with major LLM providers (OpenAI, Azure, AWS Bedrock, etc.).
- Support for **Prompt Guards** and response filtering.
- Advanced observability for token usage and costs.
- High performance with low latency overhead.

## 5. 🔍 Considered Options

### Option 1: KGateway
- **Overview:** Advanced, Envoy-based gateway (CNCF Sandbox).
- **Pros:** Extremely mature, native Gateway API support, comprehensive AI features (failover, prompt guards), proven production experience.
- **Cons:** Can be more complex to operate due to its broad feature set.

### Option 2: Envoy AI Gateway
- **Overview:** Purpose-built, community-driven GenAI gateway based on Envoy.
- **Pros:** Specifically designed for AI use cases, lightweight.
- **Cons:** Newer project, less mature than KGateway, uncertain long-term support.

## 6. ⚠️ Drawbacks
- Adds a new critical component in the AI request path.
- Potential minor increase in latency.
- Need to keep the gateway updated as LLM provider APIs evolve rapidly.

## 7. 🚀 Next Steps
1. Deploy KGateway in a dev cluster.
2. Configure routes for primary LLM providers.
3. Implement token tracking and observability dashboards.
4. Explore integration with the **Agent Gateway** project.
