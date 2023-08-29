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
app.kubernetes.io/name: {{ include "czertainly.name" . }}
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

{{/*
Return the ephemeral volume configuration
*/}}
{{- define "czertainly.ephemeralVolume" -}}
{{ include "czertainly-lib.volumes.ephemeral" (dict "volumes" .Values.volumes "global" .Values.global.volumes) }}
{{- end -}}

{{/*
Render init containers, if any
*/}}
{{- define "czertainly.customization.initContainers" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.initContainers .Values.initContainers) "context" $ ) }}
{{- end -}}

{{/*
Render sidecar containers, if any
*/}}
{{- define "czertainly.customization.sidecarContainers" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.sidecarContainers .Values.sidecarContainers) "context" $ ) }}
{{- end -}}

{{/*
Render additional volumes, if any
*/}}
{{- define "czertainly.customization.volumes" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.additionalVolumes .Values.additionalVolumes) "context" $ ) }}
{{- end -}}

{{/*
Render additional volume mounts, if any
*/}}
{{- define "czertainly.customization.volumeMounts" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.additionalVolumeMounts .Values.additionalVolumeMounts) "context" $ ) }}
{{- end -}}

{{/*
Render customized ports, if any
*/}}
{{- define "czertainly.customization.ports" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.additionalPorts .Values.additionalPorts) "context" $ ) }}
{{- end -}}

{{/*
Render customized environment variables, if any
*/}}
{{- define "czertainly.customization.env" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.additionalEnv.variables .Values.additionalEnv.variables) "context" $ ) }}
{{- end -}}

{{/*
Render customized environment variables from configmaps and secrets, if any
*/}}
{{- define "czertainly.customization.envFrom" -}}
{{- include "czertainly-lib.customizations.render.configMapEnv" ( dict "parts" (list .Values.global.additionalEnv.configMaps .Values.additionalEnv.configMaps) "context" $ ) }}
{{- include "czertainly-lib.customizations.render.secretEnv" ( dict "parts" (list .Values.global.additionalEnv.secrets .Values.additionalEnv.secrets) "context" $ ) }}
{{- end -}}
