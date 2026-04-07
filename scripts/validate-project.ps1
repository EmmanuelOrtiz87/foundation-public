# validate-project.ps1 (Foundation Core)
# Script agnostico para validar la integridad de cualquier proyecto base o derivado.

$ErrorActionPreference = 'Stop'
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Resolve-Path (Join-Path $scriptDir "..")
Set-Location $projectRoot

function Write-Check { param([string]$msg) Write-Host ">> $msg" -ForegroundColor Cyan }

Write-Check "1. Verificando Calidad y Seguridad (GGA)..."
if (Get-Command gga -ErrorAction SilentlyContinue) {
    & gga check
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   OK: GGA validado exitosamente." -ForegroundColor Green
    }
} else {
    Write-Host "   INFO: GGA no detectado en el sistema. Saltando validacion de seguridad." -ForegroundColor Gray
}

Write-Check "2. Validando Infraestructura de IA (Engram/Skills)..."
if (Test-Path "tools/Gentleman-Skills") {
    Write-Host "   OK: Biblioteca de habilidades base presente." -ForegroundColor Green
}

Write-Check "3. Generando Reporte de Sesion..."
$reviewScript = Join-Path $scriptDir "generate-session-review.ps1"
if (Test-Path $reviewScript) {
    & $reviewScript
}

Write-Check "4. Estado de Repositorio (Git)..."
$status = git status --short
if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Host "   OK: Limpio para push." -ForegroundColor Green
} else {
    Write-Host "   Cambios pendientes detectados:" -ForegroundColor Yellow
    Write-Host $status
}

Write-Host "`n====================================================" -ForegroundColor Gray
if ($LASTEXITCODE -eq 0) {
    Write-Host " VALIDACION COMPLETADA" -ForegroundColor Green -BackgroundColor Black
} else {
    Write-Host " ERROR EN VALIDACION" -ForegroundColor Red
}
Write-Host "====================================================`n" -ForegroundColor Gray

exit $LASTEXITCODE