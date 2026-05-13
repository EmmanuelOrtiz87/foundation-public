#!/usr/bin/env pwsh
param(
    [switch]$SkipFallbackTests
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$errors = 0
$ignoredPatterns = @(
    'scripts/adaptive/',
    'scripts/foundation/bootstrap-workspace.ps1',
    'scripts/setup-complete.ps1'
)

Get-ChildItem -Path (Join-Path $root 'scripts') -Recurse -File -Include '*.ps1' | ForEach-Object {
    $relativePath = $_.FullName.Substring($root.Length + 1).Replace([char]92, '/')
    foreach ($ignoredPattern in $ignoredPatterns) {
        if ($relativePath -like "$ignoredPattern*") {
            return
        }
    }

    $tokens = $null
    $parseErrors = $null
    [System.Management.Automation.Language.Parser]::ParseFile($_.FullName, [ref]$tokens, [ref]$parseErrors) | Out-Null
    if ($parseErrors.Count -gt 0) {
        Write-Host "[ERROR] Syntax issue in $($_.FullName)" -ForegroundColor Red
        $errors++
    }
}

if ($errors -gt 0) {
    Write-Host "[FAIL] Script governance found $errors issue(s)." -ForegroundColor Red
    exit 1
}

Write-Host '[OK] Script governance passed.' -ForegroundColor Green
exit 0
