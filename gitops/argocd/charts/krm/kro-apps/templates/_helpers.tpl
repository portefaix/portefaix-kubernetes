{{/*
Expand the name of the chart.
*/}}
{{- define "kro-apps.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kro-apps.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts
*/}}
{{- define "kro-apps.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kro-apps.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kro-apps.labels" -}}
helm.sh/chart: {{ include "kro-apps.chart" . }}
{{ include "kro-apps.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/part-of: {{ include "kro-apps.name" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.additionalLabels }}
{{ toYaml .Values.additionalLabels }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kro-apps.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kro-apps.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Kubernetes labels
*/}}
{{- define "kro.k8s.labels" -}}
app.kubernetes.io/component: k8s
{{- end }}

{{/*
AWS labels
*/}}
{{- define "kro.aws.labels" -}}
app.kubernetes.io/component: aws
{{- end }}

{{/*
GCP labels
*/}}
{{- define "kro.gcp.labels" -}}
app.kubernetes.io/component: gcp
{{- end }}
