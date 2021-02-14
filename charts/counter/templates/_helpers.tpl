{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "app.name" -}}

{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "app.fullapp" -}}
{{- default .Release.Namespace .Values.fullappOverride -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "app.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "app.basepath" -}}
{{- $appname := (printf "/%s" (default .Chart.Name .Values.nameOverride )) | trunc 63 | trimSuffix "-" -}}
{{- default $appname .Values.basepath -}}
{{- end -}}

{{- define "app.metadataLabels" -}}
app: {{ template "app.name" $ }}
fullapp: {{ template "app.fullapp" $ }}
chart: {{ $.Chart.Name }}
release: {{ $.Release.Name }}
"app.kubernetes.io/managed-by": {{ $.Release.Service }}
{{ range $label, $value := $.Values.extraLabels -}}
{{ $label | quote }}: {{ $value | quote }}
{{- end -}}
{{- end -}}

{{- define "app.metadataAnnotations" -}}
"meta.helm.sh/release-name": {{ $.Release.Name }}
"meta.helm.sh/release-namespace": {{ $.Release.Namespace }}
{{- end -}}