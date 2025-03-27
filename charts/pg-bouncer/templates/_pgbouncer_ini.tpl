{{/*
See https://www.pgbouncer.org/config.html for more information on the pgbouncer.ini file format.
*/}}
{{- define "pg-bouncer.pgbouncer.ini" -}}
{{- $database_host := pluck "host" .Values.global.database .Values.database | compact | first }}
{{- $database_port := pluck "port" .Values.global.database .Values.database | compact | first }}
{{- $database_name := pluck "name" .Values.global.database .Values.database | compact | first }}
{{- $database_user := pluck "username" .Values.global.database .Values.database | compact | first }}
[databases]
{{ $database_name }} = host={{ $database_host }} port={{ $database_port }} auth_user={{ $database_user }}
{{/* [pgbouncer] section */}}
{{- if $.Values.section.pgbouncer }}
[pgbouncer]
{{- range $k, $v := $.Values.section.pgbouncer }}
{{ $k }} = {{ $v }}
{{- end }}
{{- end }}
{{/* [users] section */}}
{{- if $.Values.section.users }}
[users]
{{- range $k, $v := $.Values.section.users }}
{{ $k }} = {{ $v }}
{{- end }}
{{- end }}
{{- end }}
