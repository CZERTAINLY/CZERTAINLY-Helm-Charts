{{/*
Expand the name of the chart.
*/}}
{{- define "pg-bouncer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pg-bouncer.fullname" -}}
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
{{- define "pg-bouncer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pg-bouncer.labels" -}}
helm.sh/chart: {{ include "pg-bouncer.chart" . }}
{{ include "pg-bouncer.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pg-bouncer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pg-bouncer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "pg-bouncer.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "pg-bouncer.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the image name
*/}}
{{- define "pg-bouncer.image" -}}
{{ include "czertainly-lib.images.image" (dict "image" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the image pull secret names
*/}}
{{- define "pg-bouncer.imagePullSecrets" -}}
{{ include "czertainly-lib.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) }}
{{- end -}}

{{/*
Retun the ephemeral volume configuration
*/}}
{{- define "pg-bouncer.ephemeralVolume" -}}
{{ include "czertainly-lib.volumes.ephemeral" (dict "volumes" .Values.volumes "global" .Values.global.volumes) }}
{{- end -}}

{{/*
Render init containers, if any
*/}}
{{- define "pg-bouncer.customization.initContainers" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.initContainers .Values.initContainers) "context" $ ) }}
{{- end -}}

{{/*
Render sidecar containers, if any
*/}}
{{- define "pg-bouncer.customization.sidecarContainers" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.sidecarContainers .Values.sidecarContainers) "context" $ ) }}
{{- end -}}

{{/*
Render additional volumes, if any
*/}}
{{- define "pg-bouncer.customization.volumes" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.additionalVolumes .Values.additionalVolumes) "context" $ ) }}
{{- end -}}

{{/*
Render additional volume mounts, if any
*/}}
{{- define "pg-bouncer.customization.volumeMounts" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.additionalVolumeMounts .Values.additionalVolumeMounts) "context" $ ) }}
{{- end -}}

{{/*
Render customized ports, if any
*/}}
{{- define "pg-bouncer.customization.ports" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.additionalPorts .Values.additionalPorts) "context" $ ) }}
{{- end -}}

{{/*
Render customized environment variables, if any
*/}}
{{- define "pg-bouncer.customization.env" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.additionalEnv.variables .Values.additionalEnv.variables) "context" $ ) }}
{{- end -}}

{{/*
Render customized environment variables from configmaps and secrets, if any
*/}}
{{- define "pg-bouncer.customization.envFrom" -}}
{{- include "czertainly-lib.customizations.render.configMapEnv" ( dict "parts" (list .Values.global.additionalEnv.configMaps .Values.additionalEnv.configMaps) "context" $ ) }}
{{- include "czertainly-lib.customizations.render.secretEnv" ( dict "parts" (list .Values.global.additionalEnv.secrets .Values.additionalEnv.secrets) "context" $ ) }}
{{- end -}}

{{/*
Render customized command and arguments, if any
*/}}
{{- define "pg-bouncer.image.command" -}}
{{- include "czertainly-lib.tplvalues.render" (dict "value" .Values.image.command "context" $) }}
{{- end -}}

{{- define "pg-bouncer.image.args" -}}
{{- include "czertainly-lib.tplvalues.render" (dict "value" .Values.image.args "context" $) }}
{{- end -}}
