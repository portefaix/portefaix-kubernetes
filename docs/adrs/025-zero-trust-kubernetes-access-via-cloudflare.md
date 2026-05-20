---
adr: 025
status: ✅ accepted
date: 2026-05-05
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 025 - Zero Trust Kubernetes Access via Cloudflare

## 📝 Context and Problem Statement

ADR 010 initially selected **Paralus** for Kubernetes access management. However, the Paralus project has seen a significant decline in activity and maintenance. Additionally, we are already adopting **Cloudflare Tunnels** to secure access to our web applications (Grafana, Argo CD, etc.). To simplify our infrastructure and leverage existing tools, we need a way to provide Zero Trust access to the Kubernetes API (`kubectl`) using the same security stack.

## 💡 Decision

We choose to use **Cloudflare Tunnels** combined with **Cloudflare Access** and **Authentik** (our IdP) to provide Zero Trust access to Kubernetes clusters.

### Implementation Details

1.  **Server-side:** A `cloudflared` deployment will run within each Kubernetes cluster, establishing an outbound-only tunnel to the Cloudflare edge.
2.  **Authentication:** Cloudflare Access will be integrated with **Authentik** via OIDC.
3.  **Authorization:** Access policies in Cloudflare will enforce identity checks and optional device posture requirements.
4.  **Client-side:** Developers will use the `cloudflared access tcp` proxy locally to route `kubectl` traffic through the secure tunnel.

## 📈 Consequences

- ✅ **Good:** Unified security model for both web applications and CLI tools.
- ✅ **Good:** Eliminates the need to maintain Paralus, Casbin, or Elasticsearch for access logs.
- ✅ **Good:** Clusters can remain on fully private networks with no inbound ports exposed.
- ✅ **Good:** Leveraging Cloudflare's global edge network for low-latency access.
- 🚫 **Bad:** Introducing a dependency on Cloudflare's control plane.
- 🚫 **Bad:** Requires `cloudflared` to be installed on developer machines.
- 🚀 **Action:** Deprecate Paralus installations and migrate all `kubectl` access to Cloudflare Tunnels.

## 🔗 References

- [ADR 010 - Zero Trust Implementation](./010-zero-trust.md) (Superseded)
- [RFC 004 - Zero Trust Strategy](../rfcs/004-zero-trust.md)
- [RFC 009 - IAM Strategy](../rfcs/009-iam-strategy.md)
