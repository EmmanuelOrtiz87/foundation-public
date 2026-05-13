#!/usr/bin/env pwsh
param(
    [switch]$Verbose
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $PSScriptRoot))

Write-Host '[INFO] Running public comprehensive validation' -ForegroundColor Cyan

$validateConfigs = Join-Path $root 'scripts/utilities/validate-configs.ps1'
$agentVerify = Join-Path $root 'scripts/utilities/agent-verify.ps1'

if (Test-Path $validateConfigs) {
    & $validateConfigs -ConfigDir (Join-Path $root 'config')
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

if (Test-Path $agentVerify) {
    & $agentVerify -Json | Out-Null
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Write-Host '[OK] Comprehensive validation passed.' -ForegroundColor Green
exit 0
