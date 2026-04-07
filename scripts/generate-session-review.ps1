# generate-session-review.ps1 (Foundation Core)
# Generador agnóstico de reseñas de sesión para control de cambios asistido por IA.

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Resolve-Path (Join-Path $scriptDir "..")
Set-Location $projectRoot

# Verificar si el directorio es un repositorio Git antes de proceder
git rev-parse --is-inside-work-tree 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "[INFO] No se detecto un repositorio Git. Saltando generacion de reporte de sesion." -ForegroundColor Gray
    exit 0
}

$headRef = git show-ref --head HEAD 2>$null
if ($headRef) {
    $lastCommit = git rev-parse HEAD 2>$null
} else {
    Write-Host "No se detecto un commit previo. Inicializando reporte de sesion inicial."
    $lastCommit = "Initial"
}

# Capturar cambios actuales (staged y unstaged) para el reporte de sesion
$changedFilesOutput = git status --porcelain 2>$null
$changedFiles = $changedFilesOutput | ForEach-Object { 
    if ($_.Length -gt 3) { $_.Substring(3) }
} | Where-Object { $_ -ne "" }

if ($changedFiles.Count -eq 0 -and $lastCommit -ne "Initial") {
    Write-Host "No hay cambios detectados para reportar en esta sesion."
    exit 0
}

$date = Get-Date -Format "yyyy-MM-dd"
$reviewDir = Join-Path $projectRoot "docs/code-reviews"
if (-not (Test-Path $reviewDir)) {
    New-Item -ItemType Directory -Path $reviewDir -Force | Out-Null
}

$reviewFile = Join-Path $reviewDir "${date}-session-review.md"

$contentLines = @()
$contentLines += "# Code Review: Session Changes - $date"
$contentLines += ""
$contentLines += "> [!IMPORTANT]"
$contentLines += "> Este documento es la memoria persistente de Engram para esta sesion."
$contentLines += ""
$contentLines += "**Fecha:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$contentLines += "**Reviewer:** Engram AI Agent"
$contentLines += "**Base Branch:** $(git rev-parse --abbrev-ref HEAD)"
$contentLines += ""
$contentLines += "## Archivos Cambiados"
$contentLines += ""
foreach ($file in $changedFiles) { $contentLines += "- $file" }
if ($changedFiles.Count -eq 0) { $contentLines += "- No hay archivos modificados (Commit inicial)" }

$contentLines += ""
$contentLines += "## Analisis de Arquitectura y Calidad"
$contentLines += ""
$contentLines += "[Analisis automatico del agente sobre la integridad del proyecto]"
$contentLines += ""
$contentLines += "## Checklist de Validacion"
$contentLines += ""
$contentLines += "- [ ] El codigo cumple con los estandares de Gentleman Programming"
$contentLines += "- [ ] No se han expuesto secretos o credenciales"
$contentLines += "- [ ] La arquitectura base se mantiene intacta"
$contentLines += "- [ ] Documentacion actualizada"
$contentLines += ""
$contentLines += "---"
$contentLines += "*Reporte generado por Workspace Foundation Core.*"

$contentLines -join "`n" | Out-File -FilePath $reviewFile -Encoding UTF8
Write-Host "[OK] Session review generado en: $reviewFile" -ForegroundColor Green