---
rfc: 010
status: ✅ accepted
date: 2024-08-01
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# RFC 010 - Internal Developer Portal Strategy

## 1. 📝 Summary

This RFC proposes the implementation of an Internal Developer Portal (IDP) to unify the developer experience across Portefaix. The goal is to provide a single pane of glass for discovering services, infrastructure, documentation, and automation.

## 2. 🎯 Motivation

### Current State
As the number of clusters, services, and tools (Argo CD, Terraform, Kubernetes) grows, it becomes harder for developers to find relevant information and manage their resources.

### Problems
- **Tool Sprawl:** Information is scattered across multiple dashboards (AWS, GCP, Argo CD, GitHub).
- **Onboarding:** High friction for new team members to discover existing services.
- **Infrastructure Visibility:** Difficult to track which services are running on which clusters and their current status.
- **Standardization:** No central place to enforce and visualize service standards.

## 3. 📖 Guide-level Explanation

An IDP will serve as a **Developer Self-Service Center** where:
1. **Cataloging:** All services and infrastructure are automatically discovered and listed.
2. **Scaffolding:** New services can be created using approved templates.
3. **Scorecards:** Services are graded based on security, reliability, and documentation standards.
4. **Visibility:** Developers can see their Kubernetes resources, Terraform runs, and Argo CD status in one place.

## 4. 🔬 Reference-level Explanation

### Technical Requirements
- Native integration with Kubernetes, GitHub, Argo CD, and Terraform.
- Support for "Software Catalog" using metadata (YAML).
- Ability to define custom data models for diverse infrastructure resources.
- Easy to set up and maintain without a dedicated platform team.

## 5. 🔍 Considered Options

### Option 1: Backstage
- **Overview:** Open-source framework by Spotify (CNCF Graduated).
- **Pros:** Highly extensible, massive community, full control over the platform.
- **Cons:** Very high maintenance effort (requires writing TypeScript/React), complex to configure and customize, requires hosting and operations.

### Option 2: Port
- **Overview:** Modern, SaaS-based Internal Developer Portal.
- **Pros:** Extremely fast to set up, highly flexible data model (blueprints), excellent UI, many out-of-the-box integrations, very intuitive.
- **Cons:** SaaS-only (no on-premise), vendor dependency.

## 6. ⚠️ Drawbacks
- Potential for the portal to become "another tool to check" if not integrated into daily workflows.
- Maintenance of metadata/YAML files for the software catalog.
- SaaS costs (for Port) vs. Operational costs (for Backstage).

## 7. 🚀 Next Steps
1. Initialize the Port catalog.
2. Integrate GitHub and Kubernetes clusters.
3. Define blueprints for standard Portefaix services.
4. Establish "Scorecards" to drive service quality.
