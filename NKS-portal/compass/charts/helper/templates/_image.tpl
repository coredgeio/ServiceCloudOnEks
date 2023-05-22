{{- define "helper.imageTag" -}}
  {{ if and .Values.ReleaseTag (not .Values.UseDailyBuilds) }}
    {{- printf "%s" .Values.ReleaseTag -}}
  {{ else }}
    {{- printf "%s" now | date "2006-01-02" -}}
  {{ end }}
{{- end -}}
