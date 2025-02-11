{{/*
 SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
 SPDX-License-Identifier: Apache-2.0
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "stack.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "stack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "stack.labels" }}
helm.sh/chart: {{ include "stack.chart" . }}
{{ include "stack.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: v{{ .Chart.AppVersion }}
{{- end }}
app.kubernetes.io/component: portefaix-stack
app.kubernetes.io/part-of: {{ template "stack.name" . }}-{{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.customLabels }}
{{ toYaml .Values.customLabels }}
{{- end }}
portefaix.xyz/component: stack
portefaix.xyz/version: v0.37.0
{{- end }}

{{/*
Selector labels
*/}}
{{- define "stack.selectorLabels" -}}
app.kubernetes.io/name: {{ include "stack.name" . }}-{{ .Release.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "stack.annotations" }}
notifications.argoproj.io/subscribe.on-deployed.slack: {{ .Values.notifications.slack.channel }}
notifications.argoproj.io/subscribe.on-degraded.slack: {{ .Values.notifications.slack.channel }}
notifications.argoproj.io/subscribe.on-sync-succeeded.slack: {{ .Values.notifications.slack.channel }}
notifications.argoproj.io/subscribe.on-sync-running.slack: {{ .Values.notifications.slack.channel }}
notifications.argoproj.io/subscribe.on-sync-failed: {{ .Values.notifications.slack.channel }}
notifications.argoproj.io/subscribe.on-sync-status-unknown: {{ .Values.notifications.slack.channel }}
{{- end }}
