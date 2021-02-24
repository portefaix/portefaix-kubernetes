+++
title = "Portefaix Overview"
description = "How Portefaix helps you organize your ML workflow"
weight = 10

+++

Portefaix is a platform for data scientists who want to build and experiment with
ML pipelines. Portefaix is also for ML engineers and operational teams who want
to deploy ML systems to various environments for development, testing, and
production-level serving.

## Conceptual overview

Portefaix is *the ML toolkit for Kubernetes*.
The following diagram shows Portefaix as a platform for arranging the
components of your ML system on top of Kubernetes:

<img src="/docs/images/Portefaix-overview-platform-diagram.svg"
  alt="An architectural overview of Portefaix on Kubernetes"
  class="mt-3 mb-3 border border-info rounded">

Portefaix builds on [Kubernetes](https://kubernetes.io/) as a system for
deploying, scaling, and managing complex systems.

Using the Portefaix configuration interfaces (see [below](#interfaces)) you can
specify the ML tools required for your workflow. Then you can deploy the
workflow to various clouds, local, and on-premises platforms for experimentation and
for production use.

## Next steps

See how to [install Portefaix](/docs/started/getting-started/) depending on
your chosen environment (local, cloud, or on-premises).
