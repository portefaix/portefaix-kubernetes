---
rfc: 005
status: ✅ accepted
date: 2023-08-01
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# RFC 005 - Secrets Management Strategy

## 1. 📝 Summary

This RFC proposes a shift from manual, manual-intensive secret management using Kubeseal to an automated, provider-agnostic system. The goal is to leverage cloud-native secret managers (AWS, GCP, Azure, Scaleway) and dedicated solutions like HashiCorp Vault or Akeyless directly within Kubernetes clusters.

## 2. 🎯 Motivation

### Current State
Portefaix currently relies on **Kubeseal** for Kubernetes secrets. This workflow is manual:
1. Store secret in a Cloud Secrets Manager.
2. Manually connect to the target cluster.
3. Use `kubeseal` CLI to encrypt the secret.
4. Commit the encrypted secret to Git.

### Problems
- **Operational Overhead:** High manual effort for each secret update.
- **Error-Prone:** Frequent mismatches between namespaces, environments, and secret names.
- **Scaling:** Difficult to manage secrets across a growing number of clusters and multi-cloud environments.
- **Synchronization:** No automated way to sync rotation from Cloud Providers to Kubernetes.

## 3. 📖 Guide-level Explanation

We aim to move to an **Operator-based model** where:
1. Secrets are managed centrally in a Cloud Provider or Vault.
2. A Kubernetes resource (CRD) declares the link between a Cloud Secret and a local K8s Secret.
3. A controller automatically fetches and keeps the K8s Secret in sync.

## 4. 🔬 Reference-level Explanation

### Technical Requirements
- Support for multiple backends: AWS Secrets Manager, GCP Secret Manager, Azure Key Vault, HashiCorp Vault, etc.
- Support for both Namespaced and Cluster-wide configurations.
- Automatic reconciliation when the source secret changes.

## 5. 🔍 Considered Options

### Option 1: External Secrets Operator (ESO)
- **Overview:** CNCF Sandbox project that syncs external secrets into K8s Secrets.
- **Pros:** Broadest provider support, very active community, robust reconciliation.
- **Cons:** Additional CRDs to learn.

### Option 2: Vault Secrets Operator (VSO)
- **Overview:** Official HashiCorp operator for Vault.
- **Pros:** Best-in-class Vault integration, support for dynamic secrets.
- **Cons:** Limited to Vault; doesn't solve native Cloud Provider integration directly.

### Option 3: Secrets Store CSI Driver
- **Overview:** SIG-Storage project that mounts secrets as volumes.
- **Pros:** Standard CSI interface, secrets don't live in `etcd`.
- **Cons:** Requires app changes (reading files instead of Env Vars), more complex pod specs.

### Option 4: Infisical
- **Overview:** End-to-end secret management platform.
- **Pros:** Excellent UI, cross-environment visibility.
- **Cons:** Requires enterprise license for advanced features.

## 6. ⚠️ Drawbacks
- Adds a new critical infrastructure component.
- Dependency on Cloud APIs (API rate limits, network connectivity).
- Migration effort for existing Sealed Secrets.

## 7. 🚀 Next Steps
1. Select a primary operator (ESO recommended for multi-cloud).
2. Define a standard for `SecretStore` vs `ClusterSecretStore`.
3. Create a migration plan from Kubeseal.
