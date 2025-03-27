{{- define "pg-bouncer.userlist.txt" -}}
{{- $user := pluck "username" .Values.global.database .Values.database | compact | first | quote }}
{{- $password := pluck "password" .Values.global.database .Values.database | compact | first | quote }}
{{ $user }} {{ $password }}
{{- end }}
