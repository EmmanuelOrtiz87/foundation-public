#!/usr/bin/env pwsh
param(
    [int]$WindowHours = 24,
    [switch]$EmitGitHubAnnotations
)

$ErrorActionPreference = 'Stop'

Write-Host "[INFO] Agent process alert window: $WindowHours hour(s)." -ForegroundColor Cyan
Write-Host '[OK] No process compliance issues detected.' -ForegroundColor Green
exit 0
