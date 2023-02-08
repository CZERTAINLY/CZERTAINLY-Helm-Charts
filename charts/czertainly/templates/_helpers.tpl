{{/*
Expand the name of the chart.
*/}}
{{- define "czertainly.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "czertainly.fullname" -}}
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
{{- define "czertainly.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "czertainly.labels" -}}
helm.sh/chart: {{ include "czertainly.chart" . }}
{{ include "czertainly.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "czertainly.selectorLabels" -}}
app.kubernetes.io/name: czertainly-core
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "czertainly.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "czertainly.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "czertainly.registerConnectors" -}}
{{- if .Values.commonCredentialProvider.enabled }}
registerConnectors: true
{{- end}}
{{- end}}

{{/*
Return the image name
*/}}
{{- define "czertainly.image" -}}
{{ include "czertainly-lib.images.image" (dict "image" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the image name of the auth-service
*/}}
{{- define "czertainly.opa.image" -}}
{{ include "czertainly-lib.images.image" (dict "image" .Values.opa.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the image name of the auth-service
*/}}
{{- define "czertainly.curl.image" -}}
{{ include "czertainly-lib.images.image" (dict "image" .Values.curl.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the image name of the auth-service
*/}}
{{- define "czertainly.kubectl.image" -}}
{{ include "czertainly-lib.images.image" (dict "image" .Values.kubectl.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the image pull secret names
*/}}
{{- define "czertainly.imagePullSecrets" -}}
{{ include "czertainly-lib.images.pullSecrets" (dict "images" (list .Values.image .Values.opa.image .Values.curl.image .Values.kubectl.image) "global" .Values.global) }}
{{- end -}}