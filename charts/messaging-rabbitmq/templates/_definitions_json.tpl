{{/*
Return the RabbitMQ definitions JSON for the messaging service.

Inputs:
- global: global configuration
- messagingService: messaging service configuration

Example:
{{ include "messaging-rabbitmq.definitions.json" ( dict "global" .Values.global "messagingService" .Values ) }}
*/}}
{{- define "messaging-rabbitmq.definitions.json" -}}
{{- $username := pluck "username" .global.messaging .messagingService.messaging | compact | first }}
{{- $password := pluck "password" .global.messaging .messagingService.messaging | compact | first }}
{
  "users": [
    {
      "name": "{{ $username }}",
      "password": "{{ $password }}",
      "tags": [
        "administrator"
      ],
      "limits": {}
    }
  ],
  "vhosts": [
    {
      "name": "czertainly"
    }
  ],
  "permissions": [
    {
      "user": "{{ $username }}",
      "vhost": "czertainly",
      "configure": ".*",
      "write": ".*",
      "read": ".*"
    }
  ]
}
{{- end }}
