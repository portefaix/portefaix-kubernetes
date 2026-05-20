# Portefaix Decisions

This repository tracks the strategic and architectural decisions for the **Portefaix** project. We use a two-tier documentation system to separate the "research and debate" phase from the "final decision and implementation" phase.

## 🏗️ Documentation Workflow

1. **RFC (Request for Comments):** Used for strategic research, comparing multiple options, and establishing a vision. RFCs are the place for technical debate.
2. **ADR (Architectural Decision Record):** Used to record the final choice and its immediate consequences. ADRs are concise, permanent records of the project's evolution.

---

## 📑 Decisions Index

| ID      | Subject                   | Strategy (RFC)                                       | Implementation (ADR)                                                 | Status      |
| :------ | :------------------------ | :--------------------------------------------------- | :------------------------------------------------------------------- | :---------- |
| **001** | Secrets Management        | [RFC 005](./rfcs/005-secrets-management.md)          | [ADR 005](./adrs/005-secrets-management.md)                          | ✅ Accepted |
| **002** | OpenTelemetry             | [RFC 002](./rfcs/002-opentelemetry.md)               | [ADR 006](./adrs/006-opentelemetry.md)                               | ✅ Accepted |
| **003** | Gateway API               | [RFC 013](./rfcs/013-gateway-api-strategy.md)        | [ADR 007](./adrs/007-k8s-gateway-api.md)                             | ✅ Accepted |
| **004** | Zero Trust                | [RFC 004](./rfcs/004-zero-trust.md)                  | [ADR 025](./adrs/025-zero-trust-kubernetes-access-via-cloudflare.md) | ✅ Accepted |
| **005** | Identity & Access (IAM)   | [RFC 009](./rfcs/009-iam-strategy.md)                | [ADR 011](./adrs/011-identity-provider.md)                           | ✅ Accepted |
| **006** | Developer Portal (IDP)    | [RFC 010](./rfcs/010-idp-strategy.md)                | [ADR 014](./adrs/014-internal-developer-portal.md)                   | ✅ Accepted |
| **007** | Immutable OS              | [RFC 011](./rfcs/011-immutable-os-strategy.md)       | [ADR 016](./adrs/016-immutable-os.md)                                | ✅ Accepted |
| **008** | Data Lakehouse            | [RFC 007](./rfcs/007-data-lakehouse.md)              | [ADR 017](./adrs/017-data-lakehouse.md)                              | ✅ Accepted |
| **009** | Database Operators        | [RFC 014](./rfcs/014-database-operators-strategy.md) | [ADR 020](./adrs/020-database-operators.md)                          | ✅ Accepted |
| **010** | WebAssembly (Wasm)        | [RFC 015](./rfcs/015-wasm-strategy.md)               | [ADR 021](./adrs/021-wasm.md)                                        | ✅ Accepted |
| **011** | Policy Management         | [RFC 008](./rfcs/008-policy-management.md)           | [ADR 022](./adrs/022-policies.md)                                    | ✅ Accepted |
| **012** | Change Data Capture (CDC) | [RFC 016](./rfcs/016-cdc-strategy.md)                | [ADR 026](./adrs/026-apache-iggy-for-cdc.md)                         | ✅ Accepted |
| **013** | AI Gateway                | [RFC 012](./rfcs/012-ai-gateway-strategy.md)         | [ADR 024](./adrs/024-ai-gateway.md)                                  | ✅ Accepted |

---

## 📜 License

This project is licensed under the Apache-2.0 License.
