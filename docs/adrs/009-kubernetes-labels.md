---
adr: 009
status: ✅ accepted
date: 2024-01-16
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# ADR 009 - Kubernetes labels

## 📝 Context and Problem Statement

Here are the labels we'd like to see in Kubernetes manifests:

- [Kubernetes recommended labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/)
- the `app` label
- Portefaix labels

The Portefaix labels are:

- `portefaix.xyz/version: xxx`: in all manifests
- `portefaix.xyz/component: stack`: for the `Stack` Argo-CD Applications
- `portefaix.xyz/stack: xxx`: for the Argo-CD Applications owned by a Portefaix stack
- `portefaix.xyz/env: xxx`: defines the environment

## 💡 Decision

For our charts, we must implement these labels. We can use a helper like that:

```yaml
{{/*
Common labels
*/}}
{{- define "myportefaixapp.labels" }}
helm.sh/chart: {{ include "myportefaixapp.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: xxxxxx # or specify in each manifest
app.kubernetes.io/part-of: {{ template "myportefaixapp.name" . }}
{{- include "myportefaixapp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- if .Values.additionalLabels }}
{{ toYaml .Values.additionalLabels }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "myportefaixapp.selectorLabels" }}
app.kubernetes.io/name: {{ include "myportefaixapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "myportefaixapp.db.labels" -}}
app.kubernetes.io/component: database
{{- end -}}

{{- define "myportefaixapp.controller.labels" -}}
app.kubernetes.io/component: controller
{{- end -}}
```

we could also add some labels:

```yaml
---
# -- Additional labels to add to all resources
additionalLabels:
  app: myportefaixapp
  portefaix.xyz/version: v0.1.0
  portefaix.xyz/env: homelab
```

And into the manifests:

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ template "myportefaixapp.fullname" . }}-controller
  namespace: {{ template "myportefaixapp.namespace" . }}
  labels:
    {{- include "myportefaixapp.labels" . | indent 4 }}
    {{- include "myportefaixapp.controller.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicas }}
  selector:
    matchLabels:
      {{- include "myportefaixapp.selectorLabels" . | indent 6 }}
      {{- include "myportefaixapp.controller.labels" . | nindent 6 }}
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
    type: RollingUpdate
  template:
    metadata:
      labels:
        {{- include "myportefaixapp.labels" . | indent 8 }}
        {{- include "myportefaixapp.controller.labels" . | nindent 8 }}
....
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ template "myportefaixapp.fullname" . }}-redis
  namespace: {{ template "myportefaixapp.namespace" . }}
  labels:
    {{- include "myportefaixapp.labels" . | indent 4 }}
    {{- include "myportefaixapp.db.labels" . | nindent 4 }}
spec:
...
```

## 📈 Consequences

We must refactor our charts to support all these labels. And we must create some PR on charts repositories to also.
We will also add some Kyverno policies to check these labels.
