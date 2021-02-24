+++
title = "Installing Portefaix"
description = "Overview of installation choices for various environments"
weight = 20

+++

This document provides information about setting up Portefaix in various
environments.

## Before you begin

It's important that you have some knowledge of the following systems and tools:

* [Terraform](https://terraform.io)
* [Kubernetes](https://kubernetes.io/docs/tutorials/kubernetes-basics/)
* [Kustomize](https://kustomize.io/)
* [Helm](https://helm.sh)

## Overview of installation options

The following section describes the options in more detail and links to the
relevant instructions.

<a id="installation-guides"></a>
## Installing Portefaix

There are various ways to install Portefaix. Choose one of the following options
to suit your environment (public cloud, existing Kubernetes cluster, or
a single-node cluster which you can use on a desktop or server or in the cloud).

<a id="cloud"></a>
### Installing Portefaix on a public cloud

Choose the Portefaix deployment guide for your chosen cloud:

  * To use Portefaix on Google Kubernetes Engine (GKE),
    follow the [GKE deployment guide](/docs/gcp/deploy/).
  * To use Portefaix on Amazon Elastic Kubernetes Service (EKS),
    follow the [EKS deployment guide](/docs/aws/deploy/).
  * To use Portefaix on Microsoft Azure Kubernetes Service (AKS),
    follow the [AKS deployment guide](/docs/azure/deploy/).
  * To use Portefaix on AlibabaCloud Container Service for Kubernetes (ACK),
	  follow the [ACK deployment guide](/docs/alicloud/deploy).
  <!-- * To use Portefaix on IBM Cloud (IKS),
	  follow the [IKS deployment guide](/docs/ibm/).
  * To use Portefaix on IBM Cloud (IKS),
	  follow the [IKS deployment guide](/docs/ibm/).
  * To use Portefaix on IBM Cloud (IKS),
	  follow the [IKS deployment guide](/docs/ibm/). -->

## Deployment quick reference

Below is a matrix of the platforms where you can deploy Portefaix and the
corresponding tools for each platform.

<div class="table-responsive">
  <table class="table table-bordered">
    <thead class="thead-light">
      <tr>
        <th>Cloud Provider</th>
        <th>Sops</th>
        <th>Tfsec</th>
        <th>Inspec</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Google Cloud Platform</td>
        <td><a href="https://cloud.google.com/security-key-management"> GCP KMS </a></td>
        <td><i class="fas fa-check"></i></td>
        <td><i class="fas fa-check"></i></td>
      </tr>
      <tr>
        <td>Amazon AWS</td>
        <td><a href="https://aws.amazon.com/kms/">AWS KMS</a></td>
        <td><i class="fas fa-check"></i></td>
        <td><i class="fas fa-check"></i></td>
      </tr>
      <tr>
        <td>Microsoft Azure</td>
        <td><a href="https://azure.microsoft.com/en-us/services/key-vault/">Azure KeyVault</a></td>
        <td><i class="fas fa-check"></i></td>
        <td><i class="fas fa-check"></i></td>
      </tr>
      <tr>
        <td>AlibabaCloud</td>
        <td><a href="https://www.openpgp.org/">OpenPGP</a></td>
        <td><i class="fas fa-times"></i></td>
        <td><i class="fas fa-times"></i></td>
      </tr>
      <tr>
        <td>Scaleway</td>
        <td><a href="https://www.openpgp.org/">OpenPGP</a></td>
        <td><i class="fas fa-times"></i></td>
        <td><i class="fas fa-times"></i></td>
      </tr>
      <tr>
        <td>Digital Ocean</td>
        <td><a href="https://www.openpgp.org/">OpenPGP</a></td>
        <td><i class="fas fa-times"></i></td>
        <td><i class="fas fa-times"></i></td>
      </tr>
    </tbody>
  </table>
</div>

## Troubleshooting

See the [Portefaix troubleshooting guide](/docs/other-guides/troubleshooting/).
