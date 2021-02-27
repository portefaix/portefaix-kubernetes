package main

import data.lib.kubernetes

name = input.metadata.name

sk5_labels {
  input.metadata.labels["app"]
  input.metadata.labels["env"]
  input.metadata.labels["app.kubernetes.io/manufacturer"]
}

warn[msg] {
  kubernetes.is_deployment
  not sk5_labels
  msg = sprintf("Deployment %s could include Portefaix recommended labels: https://portefaix.xyz/docs/kubernetes", [kubernetes.name])
}

warn[msg] {
  kubernetes.is_statefulset
  not sk5_labels
  msg = sprintf("Statefulset %s could include Portefaix recommended labels: https://portefaix.xyz/docs/kubernetes", [kubernetes.name])
}

warn[msg] {
  kubernetes.is_daemonset
  not sk5_labels
  msg = sprintf("Daemonset %s could include Portefaix recommended labels: https://portefaix.xyz/docs/kubernetes", [kubernetes.name])
}

warn[msg] {
  kubernetes.is_pod
  not sk5_labels
  msg = sprintf("Pod %s could include Portefaix recommended labels: https://portefaix.xyz/docs/kubernetes", [kubernetes.name])
}

warn[msg] {
  kubernetes.is_replicaset
  not sk5_labels
  msg = sprintf("ReplicaSet %s could include Portefaix recommended labels: https://portefaix.xyz/docs/kubernetes", [kubernetes.name])
}

warn[msg] {
  kubernetes.is_service
  not sk5_labels
  msg = sprintf("Service %s must include Portefaix recommended labels: https://portefaix.xyz/docs/books/kubernetes", [kubernetes.name])
}

warn[msg] {
  kubernetes.is_configmap
  not sk5_labels
  msg = sprintf("ConfigMap %s must include Portefaix recommended labels: https://portefaix.xyz/docs/books/kubernetes", [kubernetes.name])
}

warn[msg] {
  kubernetes.is_secret
  not sk5_labels
  msg = sprintf("Secret %s must include Portefaix recommended labels: https://portefaix.xyz/docs/books/kubernetes", [kubernetes.name])
}

warn[msg] {
  kubernetes.is_service_account
  not sk5_labels
  msg = sprintf("ServiceAccount %s must include Portefaix recommended labels: https://portefaix.xyz/docs/books/kubernetes", [kubernetes.name])
}
