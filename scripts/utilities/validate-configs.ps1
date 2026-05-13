#!/usr/bin/env pwsh
param(
    [string]$ConfigDir = ''
)

$ErrorActionPreference = 'Stop'

if (-not $ConfigDir) {
    $ConfigDir = Join-Path $PSScriptRoot '..\..\config'
}

if (-not (Test-Path $ConfigDir)) {
    Write-Host "[WARN] Config directory not found: $ConfigDir" -ForegroundColor Yellow
    exit 0
}

$errors = 0
Get-ChildItem -Path $ConfigDir -Recurse -File -Include '*.json' | ForEach-Object {
    try {
        $null = Get-Content $_.FullName -Raw | ConvertFrom-Json
    } catch {
        Write-Host "[ERROR] Invalid JSON: $($_.FullName)" -ForegroundColor Red
        $errors++
    }
}

if ($errors -gt 0) {
    Write-Host "[FAIL] Config validation found $errors issue(s)." -ForegroundColor Red
    exit 1
}

Write-Host '[OK] Config validation passed.' -ForegroundColor Green
exit 0
