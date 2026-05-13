#!/usr/bin/env pwsh
param(
    [switch]$Json,
    [string]$RootPath = ''
)

$ErrorActionPreference = 'Stop'

if (-not $RootPath) {
    $RootPath = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
}

$checks = @()
$failed = 0
$warnings = 0

$requiredPaths = @(
    'README.md',
    'scripts/run-tests-simple.ps1',
    'scripts/utilities/validate-configs.ps1',
    'scripts/utilities/agent-verify.ps1',
    '.github/workflows/public-quality-gate.yml'
)

foreach ($relativePath in $requiredPaths) {
    $fullPath = Join-Path $RootPath $relativePath
    $passed = Test-Path $fullPath
    if (-not $passed) { $failed++ }
    $checks += [pscustomobject]@{
        Name = $relativePath
        Passed = $passed
        Detail = if ($passed) { 'Present' } else { 'Missing' }
    }
}

$configValidator = Join-Path $RootPath 'scripts/utilities/validate-configs.ps1'
if (Test-Path $configValidator) {
    & $configValidator -ConfigDir (Join-Path $RootPath 'config') | Out-Null
    if ($LASTEXITCODE -ne 0) {
        $failed++
        $checks += [pscustomobject]@{ Name = 'config validation'; Passed = $false; Detail = 'validate-configs.ps1 reported failures' }
    } else {
        $checks += [pscustomobject]@{ Name = 'config validation'; Passed = $true; Detail = 'Config JSON syntax valid' }
    }
} else {
    $warnings++
    $checks += [pscustomobject]@{ Name = 'config validation'; Passed = $false; Detail = 'validate-configs.ps1 missing' }
}

$summary = [pscustomobject]@{
    total = $checks.Count
    passed = ($checks | Where-Object { $_.Passed }).Count
    failed = $failed
    warnings = $warnings
}

$result = [pscustomobject]@{
    timestamp = (Get-Date).ToString('o')
    checks = $checks
    summary = $summary
}

if ($Json) {
    $result | ConvertTo-Json -Depth 5
} else {
    foreach ($check in $checks) {
        if ($check.Passed) {
            Write-Host "[PASS] $($check.Name) - $($check.Detail)" -ForegroundColor Green
        } else {
            Write-Host "[FAIL] $($check.Name) - $($check.Detail)" -ForegroundColor Red
        }
    }
    Write-Host "Result: $($summary.passed)/$($summary.total) passed, $($summary.failed) failed, $warnings warning(s)."
}

exit $failed
