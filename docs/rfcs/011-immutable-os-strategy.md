---
rfc: 011
status: ✅ accepted
date: 2024-09-01
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# RFC 011 - Immutable Operating System Strategy

## 1. 📝 Summary

This RFC proposes the adoption of an immutable, container-optimized operating system for Portefaix Kubernetes nodes. The goal is to move away from general-purpose distributions towards a declarative, secure, and minimal OS that is managed as part of the Kubernetes lifecycle.

## 2. 🎯 Motivation

### Current State
Portefaix currently uses various Linux distributions (standard Ubuntu, Debian, or generic Cloud images). These systems require traditional management (SSH, configuration management, manual patching) and contain many unnecessary components.

### Problems
- **Large Attack Surface:** General-purpose OSs include shells, package managers, and services that are not needed to run containers.
- **Drift:** Manual changes via SSH lead to inconsistent nodes within a cluster.
- **Maintenance Overhead:** Keeping the OS patched and synchronized with the Kubernetes version is complex.
- **Reliability:** Standard OSs can be modified at runtime, leading to unpredictable behavior.

## 3. 📖 Guide-level Explanation

We will transition to an **Immutable Operating System** model:
1. **Minimality:** The OS contains only the Linux kernel and the components necessary to run Kubernetes (Kubelet, Containerd).
2. **Immutability:** The root filesystem is read-only. Updates are performed by replacing the entire image, not by patching packages.
3. **Declarative Configuration:** The entire OS is configured via a single YAML file, similar to Kubernetes resources.
4. **API-Driven:** No SSH access; the OS is managed via a dedicated API/CLI.

## 4. 🔬 Reference-level Explanation

### Technical Requirements
- Support for multiple environments (Bare metal/Homelab and Cloud).
- Native integration with Kubernetes (OS and K8s versions managed together).
- Security features: SELinux/AppArmor, hardened kernel, minimal attack surface.
- Infrastructure-as-Code support (Terraform/OpenTofu).

## 5. 🔍 Considered Options

### Option 1: Talos
- **Overview:** Modern, API-managed Linux distribution designed specifically for Kubernetes.
- **Pros:** No SSH (API-only), completely declarative, extremely minimal and secure, optimized for K8s.
- **Cons:** Learning curve for the API-driven approach (no shell).

### Option 2: Kairos
- **Overview:** Meta-distribution that can turn any OS into an immutable K8s node.
- **Pros:** High flexibility, modular.
- **Cons:** Potentially more complex to configure than a purpose-built OS.

### Option 3: Flatcar
- **Overview:** Community-driven fork of CoreOS Container Linux.
- **Pros:** Stable, well-known, very flexible for various deployments.
- **Cons:** Still allows SSH, less "opinionated" about Kubernetes integration than Talos.

### Option 4: BottleRocket (AWS)
- **Overview:** AWS-built OS for containers.
- **Pros:** Perfect AWS integration, high performance.
- **Cons:** Strongly tied to the AWS ecosystem; less suitable for multi-cloud/homelab.

## 6. ⚠️ Drawbacks
- Significant change in operational habits (no SSH, no `apt-get`).
- Requires rebuilding nodes/clusters for migration.
- Troubleshooting requires learning new tools (e.g., `talosctl`).

## 7. 🚀 Next Steps
1. Perform a PoC with Talos in the Homelab environment.
2. Develop Terraform modules for Talos deployment.
3. Establish a standard configuration template for Portefaix nodes.
