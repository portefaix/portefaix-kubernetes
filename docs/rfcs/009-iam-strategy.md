---
rfc: 009
status: ✅ accepted
date: 2024-04-01
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# RFC 009 - Identity & Access Management Strategy

## 1. 📝 Summary

This RFC proposes a unified Identity & Access Management (IAM) strategy for Portefaix. It covers the selection of an Identity Provider (IdP) for user management and MFA, as well as an OAuth2/OIDC connector to federate identity to Kubernetes and other applications.

## 2. 🎯 Motivation

### Current State
Portefaix infrastructure is growing and requires a robust way to manage user identities, groups, and permissions across multiple cloud environments and internal tools (Argo CD, Grafana, etc.).

### Problems
- **Siloed Identities:** Using different credentials for different tools.
- **Lack of MFA:** Need for strong authentication across all infrastructure components.
- **Manual User Management:** Onboarding/offboarding users manually is inefficient.
- **Kubernetes Federation:** Need a standard way to map external identities to Kubernetes RBAC.

## 3. 📖 Guide-level Explanation

We will implement a two-tier IAM architecture:
1. **The Identity Provider (IdP):** Acts as the "source of truth" for user accounts and MFA.
2. **The OIDC Federated Connector:** Acts as a bridge between the IdP and various consumers (Kubernetes clusters, internal apps), translating different identity protocols into standard OIDC tokens.

## 4. 🔬 Reference-level Explanation

### Technical Requirements
- Support for multiple MFA methods (TOTP, WebAuthn/FIDO2).
- Comprehensive UI for both users (self-service) and administrators.
- Native integration with Kubernetes RBAC.
- High availability and persistence of identity data.

## 5. 🔍 Considered Options

### Tier 1: Identity Provider (IdP)

#### Option 1: Keycloak
- **Pros:** CNCF project, extremely feature-rich, supports almost every protocol.
- **Cons:** Heavy resource usage, complex configuration.

#### Option 2: Ory Kratos
- **Pros:** API-first, very secure, well-integrated with other Ory tools.
- **Cons:** No built-in UI for end-users (requires custom development).

#### Option 3: Authentik
- **Pros:** All-in-one solution, excellent UI, robust user management, supports many MFA methods out-of-the-box.
- **Cons:** Newer than Keycloak.

### Tier 2: OAuth2 / OIDC Connector

#### Option 1: Ory Hydra
- **Pros:** High performance, security-focused.
- **Cons:** Requires a database, focused strictly on OAuth2/OIDC issuance.

#### Option 2: Dex
- **Pros:** CNCF Sandbox project, lightweight, already widely used by tools like Argo CD, supports multiple upstream connectors.
- **Cons:** Configuration is primarily static/file-based.

## 6. ⚠️ Drawbacks
- Complexity of managing two identity-related components.
- Risk of lock-out if the IAM stack is unavailable.
- Need for secure backups of the identity database.

## 7. 🚀 Next Steps
1. Deploy Authentik as the primary IdP.
2. Configure Dex to use Authentik as its upstream identity source.
3. Integrate Argo CD and Kubernetes API servers with Dex/Authentik.
