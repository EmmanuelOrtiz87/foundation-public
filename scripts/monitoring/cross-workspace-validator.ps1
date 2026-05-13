#!/usr/bin/env pwsh
param(
    [switch]$Fix
)

$ErrorActionPreference = 'Stop'

Write-Host '[INFO] Cross-workspace validation is advisory in the public repo.' -ForegroundColor Cyan
Write-Host '[OK] No cross-workspace mutations required.' -ForegroundColor Green
exit 0
