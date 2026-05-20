---
adr: 011
status: ✅ accepted
date: 2024-04-22
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 011 - Identity Provider Implementation

## 📝 Context and Problem Statement

We need a central Identity Provider (IdP) to manage user accounts, groups, and Multi-Factor Authentication (MFA) across our infrastructure.

## 💡 Decision

We choose **Authentik** as our primary Identity Provider.

## 📈 Consequences

- ✅ **Good:** Unified user management with a modern UI.
- ✅ **Good:** Robust MFA support (TOTP, WebAuthn).
- ✅ **Good:** Self-service capabilities for users.
- 🚫 **Bad:** New critical system to manage and back up.
- 🚀 **Action:** Setup Authentik and configure applications to use it for authentication.

## 🔗 References

- [RFC 009 - Identity & Access Management Strategy](../rfcs/009-iam-strategy.md) : Detailed evaluation of Authentik vs. Keycloak vs. Kratos.
