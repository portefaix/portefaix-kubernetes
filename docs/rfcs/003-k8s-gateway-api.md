---
rfc: 003
status: ✅ accepted
date: 2023-09-26
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# RFC 003 - Kubernetes Gateway API Adoption

## 1. 📝 Summary

This RFC proposes transitioning Portefaix clusters from the legacy Ingress API to the modern **Kubernetes Gateway API**. As the official successor to Ingress, the Gateway API provides a more expressive, extensible, and role-oriented interface for traffic management. This proposal evaluates several implementations and recommends **Traefik** as the unified solution for non-managed environments.

## 2. 🎯 Motivation: From Legacy to Future

### The Legacy: Kubernetes Ingress

The Ingress API was designed years ago as a simple way to bring HTTP traffic into a cluster. However, it has become "legacy" in its design due to several fundamental limitations:

- **Annotation Overload:** To support modern features (canary, retries, header manipulation), every provider had to invent their own `metadata.annotations`, leading to "annotation hell" and zero portability.
- **Single-Resource Bottleneck:** A single Ingress resource often mixes infrastructure concerns (TLS certificates) with application routing, creating friction between Ops and Dev teams.
- **Protocol Limitations:** Ingress is strictly HTTP/S. It lacks native support for gRPC, TCP, or UDP without proprietary extensions.

### The Future: Kubernetes Gateway API

The Gateway API is not just an update; it's a re-imagining of traffic management:

- **General Availability (GA):** It is now a stable, standard Kubernetes API supported by the entire ecosystem.
- **Role-Oriented:** It splits configuration into `GatewayClass` (Infra), `Gateway` (Ops), and `HTTPRoute` (Dev).
- **Native Expressiveness:** Features that required annotations in Ingress (like header-based routing or traffic splitting) are now first-class fields in the API.

## 3. Ingress vs. Gateway API: Key Differences

| Feature                | Ingress (Legacy)                     | Gateway API (The Future)                  |
| :--------------------- | :----------------------------------- | :---------------------------------------- |
| **API Expressiveness** | Basic (Host/Path)                    | Advanced (Headers, Query Params, Methods) |
| **Protocol Support**   | HTTP/S Only                          | HTTP, gRPC, TCP, UDP, TLS                 |
| **Portability**        | Low (Provider-specific annotations)  | High (Standardized specs)                 |
| **Management**         | Monolithic (One file for everything) | Decoupled (Separation of concerns)        |
| **Traffic Splitting**  | Requires 3rd party tools/annotations | Native support for Canary/Blue-Green      |
| **Multi-tenancy**      | Poor isolation                       | Strong cross-namespace support            |

## 4. Proposed Strategy

### Implementation Choice

We must choose a controller that supports this new API while easing the transition.

- **For Cloud Providers:** Use native controllers (AWS Gateway API Controller, GKE Gateway, Azure Application Gateway for Containers).
- **For Generic/Homelab:** We need to choose a controller.

## 5. Unresolved Questions

- **Performance Impact:** Will the additional CRDs and decoupling layer introduce latency compared to simple Nginx Ingress?
- **Tooling Parity:** Do our current monitoring and logging stacks (Grafana/Loki) need updates to parse Gateway API specific metrics?

## Next Steps

1. Choose a Gateway API provider
2. Convert one core service from `Ingress` to `HTTPRoute`.
3. Update Portefaix documentation to mark `Ingress` as deprecated.
