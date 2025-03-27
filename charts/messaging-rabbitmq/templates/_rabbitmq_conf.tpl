{{/*
Retrieves the RabbitMQ configuration for the messaging service.

Inputs:
- global: global configuration
- messagingService: messaging service configuration

Example:
{{ include "messaging-rabbitmq.rabbitmq.conf" ( dict "global" .Values.global "messagingService" .Values ) }}
*/}}
{{- define "messaging-rabbitmq.rabbitmq.conf" -}}
cluster_formation.peer_discovery_backend = rabbit_peer_discovery_k8s
cluster_formation.k8s.host = kubernetes.default
queue_master_locator=min-masters

## Logging to console
log.console = true
log.console.level = {{ .messagingService.logging.level }}
log.file = false

{{- if .global.messaging.remoteAccess }}
## Management plugin
loopback_users = none
{{- end }}
{{- end }}
