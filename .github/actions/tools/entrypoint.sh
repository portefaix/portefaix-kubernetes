#!/bin/bash

set -eu

YQ_VERSION="v4.6.1"
KUSTOMIZE_VERSION="4.1.3"
KUBEVAL_VERSION="0.15.0"
KUBECONFORM_VERSION="v0.4.7"
OPA_VERSION="v0.28.0"
CONFTEST_VERSION="0.25.0"
JB_VERSION="v0.4.0"


mkdir -p "${GITHUB_WORKSPACE}/bin"
cd "${GITHUB_WORKSPACE}/bin"

curl -sL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64" -o yq
chmod +x "${GITHUB_WORKSPACE}/bin/yq"

kustomize_url="https://github.com/kubernetes-sigs/kustomize/releases/download" && \
curl -sL "${kustomize_url}/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" | \
tar xz
chmod +x "${GITHUB_WORKSPACE}/bin/kustomize"

curl -sL "https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz" | \
tar xz
chmod +x "${GITHUB_WORKSPACE}/bin/kubeval"

curl -sL "https://github.com/yannh/kubeconform/releases/download/${KUBECONFORM_VERSION}/kubeconform-linux-amd64.tar.gz" | \
tar xz
chmod +x "${GITHUB_WORKSPACE}/bin/kubeconform"

curl -sL "https://github.com/open-policy-agent/opa/releases/download/${OPA_VERSION}/opa_linux_amd64" -o opa
chmod +x "${GITHUB_WORKSPACE}/bin/opa"

curl -sL "https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz" | \
tar xz
chmod +x "${GITHUB_WORKSPACE}/bin/conftest"

curl -sL "https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/${JB_VERSION}/jb-linux-amd64" -o jb
chmod +x "${GITHUB_WORKSPACE}/bin/jb"

echo "${GITHUB_WORKSPACE}/bin" >> "${GITHUB_PATH}"
echo "$RUNNER_WORKSPACE/$(basename "${GITHUB_REPOSITORY}")/bin" >> "${GITHUB_PATH}"
