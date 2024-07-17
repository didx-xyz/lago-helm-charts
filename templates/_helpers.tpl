{{- define "secret-path" }}
{{- if .Values.global.existingSecret -}}
{{ .Values.global.existingSecret }}
{{- else -}}
{{ .Release.Name }}-secrets
{{- end }}
{{- end}}

{{- define "kubectlVersion" }}
{{- if .Values.global.kubectlVersion -}}
{{ .Values.global.kubectlVersion }}
{{- else -}}
{{ printf "%s.%s" .Capabilities.KubeVersion.Major .Capabilities.KubeVersion.Minor }}
{{- end }}
{{- end}}

{{- define "migrateJobName" }}
{{- if .Values.job.migrate.nameOverride -}}
{{ .Values.job.migrate.nameOverride }}
{{- else -}}
{{ printf "%s-migrate-%s" .Release.Name (.Values | toYaml | cat .Chart.Version | sha256sum | trunc 8) }}
{{- end }}
{{- end}}

{{/*
Create chart name and version to be used by labels
*/}}
{{- define "chartNameVersioned" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Kubernetes standard labels
*/}}
{{- define "standardLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
helm.sh/chart: {{ include "chartNameVersioned" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Chart.AppVersion }}
app.kubernetes.io/version: {{ . | quote }}
{{- end -}}
{{- end -}}