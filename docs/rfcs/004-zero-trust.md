---
rfc: 004
status: ✅ accepted
date: 2023-12-15
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# RFC 004 - Zero Trust Strategy

## 1. 📝 Summary

This RFC proposes the adoption of a **Zero Trust Architecture (ZTA)** for securing access to Portefaix infrastructure, including Kubernetes clusters, databases, and servers. We aim to move away from traditional perimeter-based security and "trusted" networks towards a "never trust, always verify" model. This document outlines the core principles, evaluates potential solutions, and seeks consensus on the strategic direction for infrastructure access control.

## 2. 🎯 Motivation

### Current State

Currently, access to Portefaix infrastructure relies on traditional methods:
- **Kubernetes:** Static kubeconfig files and long-lived certificates.
- **Servers:** SSH keys managed manually or via basic automation.
- **Databases:** Static credentials and network-level access (VPN/VPC peering).

### Problems with Current Approach

- **Implicit Trust:** Once a user is "inside" the network or has a credential, they are often implicitly trusted.
- **Credential Proliferation:** Managing and rotating thousands of SSH keys and kubeconfigs is operationally complex and error-prone.
- **Lack of Visibility:** Audit logs for who did what inside a session (e.g., specific `kubectl` commands or `ssh` actions) are fragmented or non-existent.
- **Static Access:** Access is often binary (all or nothing) and doesn't adapt to the user's current context (device health, location, etc.).
- **Perimeter Fragility:** If the VPN or a single set of credentials is compromised, the entire infrastructure is at risk.

### Why Zero Trust?

The Zero Trust security model operates on three main principles:
1. **Verify Explicitly:** Always authenticate and authorize based on all available data points (identity, location, device health, service, or workload).
2. **Use Least Privilege Access:** Limit user access with Just-In-Time (JIT) and Just-Enough-Access (JEA).
3. **Assume Breach:** Minimize impact and prevent lateral movement by segmenting networks, users, devices, and application awareness.

## 3. 📖 Guide-level Explanation

### Desired Workflow

We want to transition to a workflow where access is ephemeral and identity-centric:

1. **Login with Central Identity:**
   Users log in via our central Identity Provider (IdP) using Multi-Factor Authentication (MFA).

   ```bash
   # Example login flow
   zt-cli login --idp portefaix-idp
   ```

2. **Discover Resources:**
   Users can see only the resources (clusters, servers, DBs) they are authorized to access.

   ```bash
   zt-cli list clusters
   # Returns: prod-aws, staging-gcp, dev-scaleway
   ```

3. **Just-In-Time Access:**
   Access is granted for a limited time (e.g., 8 hours). No static keys are stored on the user's machine.

   ```bash
   zt-cli access cluster prod-aws
   # Generates a temporary, short-lived kubeconfig
   ```

4. **Full Auditing:**
   Every command is logged and can be replayed if necessary for security analysis.

### Comparison with Current Approach

| Feature | Current (Traditional) | Desired (Zero Trust) |
| :--- | :--- | :--- |
| **Trust Model** | Perimeter-based (VPN) | Identity-based (No VPN required) |
| **Credentials** | Static (SSH keys, Kubeconfigs) | Ephemeral (Short-lived tokens/certs) |
| **Audit** | High-level (Connection logs) | Deep (Session recording, command logs) |
| **Access Control** | Coarse-grained | Fine-grained (RBAC/ABAC) |
| **Visibility** | Siloed | Unified across all resources |

## 4. 🔬 Reference-level Explanation

### Core Components

Any Zero Trust solution for Portefaix must provide:

1. **Identity Integration:** Native support for OIDC/SAML (e.g., GitHub, Google, Okta, Keycloak).
2. **Multi-Protocol Support:** A single pane of glass for Kubernetes (HTTPS), SSH, and various Databases (TCP).
3. **Access Proxy:** A gateway that intercepts all requests and validates identity/policies.
4. **Audit Engine:** Centralized logging of all sessions and commands.
5. **Admission Control:** Integration with Kubernetes Admission Controllers to enforce security policies.

### Technical Requirements

- **Scalability:** Must handle multiple clusters across different cloud providers (AWS, GCP, Azure, Scaleway).
- **Observability:** Export logs to our existing OpenTelemetry/Loki stack (see RFC 002).
- **GitOps Friendly:** Configuration should be manageable via CRDs or standard YAML files.
- **Connectivity:** Support for various network topologies, including private clusters without public IPs.

## 5. 🔍 Considered Options

### Option 1: Paralus

**Overview:** An open-source (CNCF) tool that provides a unified way to manage access to multiple Kubernetes clusters.

- **Pros:**
  - ✅ **Kubernetes Focused:** Deep integration with K8s primitives.
  - ✅ **Standard Tools:** Uses Ory Kratos for identity and Casbin for RBAC.
  - ✅ **Audit Trails:** Comprehensive logging of K8s actions.
- **Cons:**
  - 🚫 **Limited Scope:** Primarily focused on Kubernetes; lacks native support for non-K8s SSH or DB access.
  - 🚫 **Dependency:** Relies on Elasticsearch (though Meilisearch might be an alternative).

### Option 2: Teleport

**Overview:** A modern replacement for SSH and VPN that also supports Kubernetes, Databases, and Windows.

- **Pros:**
  - ✅ **Broad Support:** One tool for everything (K8s, SSH, DBs, Apps).
  - ✅ **Session Recording:** High-fidelity session recordings for SSH and K8s.
  - ✅ **Maturity:** Highly stable and widely used in production.
- **Cons:**
  - 🚫 **SSO Limits:** Open Source version is limited to GitHub SSO.
  - 🚫 **Complex Setup:** Significant infrastructure required for high-availability.

### Option 3: BastionZero

**Overview:** A SaaS-based Zero Trust solution that doesn't require a permanent bastion or VPN.

- **Pros:**
  - ✅ **Ease of Use:** Very quick to set up and manage.
  - ✅ **No Public Entry:** Resources don't need to be exposed to the internet.
- **Cons:**
  - 🚫 **Vendor Dependency:** SaaS-first model; less control over the backend.
  - 🚫 **Acquisition Risk:** Recent acquisition by Cloudflare may change the roadmap.

### Option 4: Cloudflare Tunnels (Chosen Path)

**Overview:** An identity-aware proxy that connects infrastructure to the Cloudflare edge without opening inbound firewall ports.

- **Pros:**
  - ✅ **Unified Platform:** Same tool for Web Apps (Grafana, Argo CD) and Infrastructure (SSH, K8s).
  - ✅ **No Public IP:** Infrastructure stays on private networks.
  - ✅ **Native SSO:** Deep integration with our Authentik IdP via OIDC.
- **Cons:**
  - 🚫 **External Dependency:** Relies on Cloudflare's global infrastructure.
  - 🚫 **Client Requirements:** Requires `cloudflared` on local machines for TCP/Kubernetes access.

## 6. ⚠️ Drawbacks

- **Operational Complexity:** Adding a new layer for all infrastructure access.
- **Point of Failure:** If the Zero Trust gateway is down, all infrastructure access is lost.
- **Learning Curve:** Teams must adopt new CLIs and workflows.
- **Resource Usage:** Gateways and proxies consume CPU/Memory across all clusters.

## 7. Unresolved Questions

1. **Which tool provides the best balance of multi-cloud support and protocol coverage?**
2. **Should we prioritize a K8s-native tool (Paralus) or a broader infrastructure tool (Teleport)?**
3. **How do we handle existing automated systems (CI/CD) that currently use static service accounts?**
4. **Is Elasticsearch a strict requirement for Paralus, or can we use a lighter alternative like Meilisearch?**

## 8. Future Possibilities

- **Identity-Aware Proxy (IAP) for Web Apps:** Using the same system to protect internal dashboards (Grafana, Argo CD).
- **Device Health Attestation:** Only allow access from encrypted, corporate-managed devices.
- **Auto-Provisioning:** Automatically adding/removing access based on HR systems or team membership.

## Next Steps

1. Implement Zero Trust access via Cloudflare Tunnels for all internal applications and Kubernetes API servers.
2. Integrate Cloudflare Access with the Authentik IdP.
3. Document the architecture in ADR 025.
