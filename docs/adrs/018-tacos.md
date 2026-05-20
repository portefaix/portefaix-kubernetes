---
adr: 018
status: ✅ accepted
date: 2024-11-12
deciders: nlamirault
consulted:
informed:
---

# ADR 018 - TACOS

## 📝 Context and Problem Statement

TACOS, short for Terraform Automation and Collaboration Software, provides a robust framework for efficiently managing
and operating Terraform codebases.

Features include:

- Collaborative & Concurrent Runs (sounds a lot similar to “jobs” doesn’t it?)
- VCS connections (GitHub, GitLab, Bitbucket etc)
- Notifications / Webhooks
- Remote Plans and Applies
- State Management (Storage, History, and Locking)
- Private Module Registry
- Role Based Access Control
- Drift Detection
- Cost Estimation
- GUI

## Considered Options

1. [Terraform Cloud](https://app.terraform.io/)
2. [Scalr](https://www.scalr.com/)
3. [Env0](https://www.env0.com/)
4. [Spacelift](https://spacelift.io/)
5. [Digger](https://digger.dev/)

## Pros and Cons of the Options

### Terraform Cloud

- ✅ Policy As code (Sentinel)
- ✅ Private Module Registry
- ✅ RBAC
- ✅ Secrets Management
- ✅ State Management
- ✅ Webhooks
- ❌ Terraform / OpenTofu

### Scalr

- ✅ Secure remote run execution and state storage
- ✅ Integrate with the Terraform CLI or Version Control
- ✅ Organize with workspaces and environments
- ✅ Unlimited resources under management
- ✅ SAML, RBAC, and OPA
- ✅ Terraform / OpenTofu

### Env0

- ✅ Role Based Access Control
- ✅ Custom Workflows
- ✅ Private Module Registry
- ✅ Automatic Drift Detection
- ✅ Dashboards
- ✅ Terraform / OpenTofu

### Spacelift

- ✅ Policy as Code Framework based on OPA
- ✅ Credential-less integration with major cloud providers (AWS, Azure, GCP)
- ✅ VCS Integration with Github, Gitlab, Bitbucket, and Azure DevOps
- ✅ Cloud cost estimation (provided by Infracost)
- ✅ Spacelift Terraform Provider
- ✅ SSO Integration with managed OIDC
- ✅ Resource Visualisation
- ✅ Blueprints
- ✅ Terraform / OpenTofu

### Digger

- ✅ Unlimited Resources under management
- ✅ OIDC
- ✅ Apply Serialization in your existing CI
- ✅ Plan Policies
- ✅ Apply via comment
- ✅ Plan Preview
- ✅ Runs within your CI such as GitHub Action so doesn’t require hosting/maintenance of an additional server
- ✅ Terraform / OpenTofu

## 💡 Decision

Each of these tools has its strengths depending on needs around automation, governance, and team integration.

For a large organization needing advanced governance, Scalr is ideal; for DevOps teams with collaborative environment
needs, env0 is often preferred; Spacelift works well for teams focused on CI/CD; and for smaller projects or startups
with an open-source focus, Digger is an effective, affordable solution.

We have decided to use **Spacelift**.

## 📈 Consequences

Start to move our Terraform Cloud setup to Spacelift.
