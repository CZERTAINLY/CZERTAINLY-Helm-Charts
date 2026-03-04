{{/*
Expand the name of the chart.
*/}}
{{- define "rabbitmq-bootstrap.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rabbitmq-bootstrap.fullname" -}}
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
{{- define "rabbitmq-bootstrap.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rabbitmq-bootstrap.labels" -}}
helm.sh/chart: {{ include "rabbitmq-bootstrap.chart" . }}
{{ include "rabbitmq-bootstrap.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rabbitmq-bootstrap.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rabbitmq-bootstrap.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rabbitmq-bootstrap.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "rabbitmq-bootstrap.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the image name
*/}}
{{- define "rabbitmq-bootstrap.image" -}}
{{ include "czertainly-lib.images.image" (dict "image" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the image name of the curl init container
*/}}
{{- define "rabbitmq-bootstrap.curl.image" -}}
{{ include "czertainly-lib.images.image" (dict "image" .Values.curl.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the image pull secret names
*/}}
{{- define "rabbitmq-bootstrap.imagePullSecrets" -}}
{{ include "czertainly-lib.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the ephemeral volume configuration
*/}}
{{- define "rabbitmq-bootstrap.ephemeralVolume" -}}
{{ include "czertainly-lib.volumes.ephemeral" (dict "volumes" .Values.volumes "global" .Values.global.volumes) }}
{{- end -}}

{{/*
Render init containers, if any
*/}}
{{- define "rabbitmq-bootstrap.customization.initContainers" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.initContainers .Values.initContainers) "context" $ ) }}
{{- end -}}

{{/*
Render sidecar containers, if any
*/}}
{{- define "rabbitmq-bootstrap.customization.sidecarContainers" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.sidecarContainers .Values.sidecarContainers) "context" $ ) }}
{{- end -}}

{{/*
Render additional volumes, if any
*/}}
{{- define "rabbitmq-bootstrap.customization.volumes" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.additionalVolumes .Values.additionalVolumes) "context" $ ) }}
{{- end -}}

{{/*
Render additional volume mounts, if any
*/}}
{{- define "rabbitmq-bootstrap.customization.volumeMounts" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.additionalVolumeMounts .Values.additionalVolumeMounts) "context" $ ) }}
{{- end -}}

{{/*
Render customized ports, if any
*/}}
{{- define "rabbitmq-bootstrap.customization.ports" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.additionalPorts .Values.additionalPorts) "context" $ ) }}
{{- end -}}

{{/*
Render customized environment variables, if any
*/}}
{{- define "rabbitmq-bootstrap.customization.env" -}}
{{- include "czertainly-lib.customizations.render.yaml" ( dict "parts" (list .Values.global.additionalEnv.variables .Values.additionalEnv.variables) "context" $ ) }}
{{- end -}}

{{/*
Render customized environment variables from configmaps and secrets, if any
*/}}
{{- define "rabbitmq-bootstrap.customization.envFrom" -}}
{{- include "czertainly-lib.customizations.render.configMapEnv" ( dict "parts" (list .Values.global.additionalEnv.configMaps .Values.additionalEnv.configMaps) "context" $ ) }}
{{- include "czertainly-lib.customizations.render.secretEnv" ( dict "parts" (list .Values.global.additionalEnv.secrets .Values.additionalEnv.secrets) "context" $ ) }}
{{- end -}}

{{/*
Render customized command and arguments, if any
*/}}
{{- define "rabbitmq-bootstrap.image.command" -}}
{{- include "czertainly-lib.tplvalues.render" (dict "value" .Values.image.command "context" $) }}
{{- end -}}

{{- define "rabbitmq-bootstrap.image.args" -}}
{{- include "czertainly-lib.tplvalues.render" (dict "value" .Values.image.args "context" $) }}
{{- end -}}

{{- define "rabbitmq-bootstrap.curl.image.command" -}}
{{- include "czertainly-lib.tplvalues.render" (dict "value" .Values.curl.image.command "context" $) }}
{{- end -}}

{{- define "rabbitmq-bootstrap.curl.image.args" -}}
{{- include "czertainly-lib.tplvalues.render" (dict "value" .Values.curl.image.args "context" $) }}
{{- end -}}
