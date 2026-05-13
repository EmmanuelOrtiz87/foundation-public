#!/usr/bin/env pwsh
param(
    [string]$Action = 'validate',
    [switch]$AsJson
)

$result = [pscustomobject]@{
    action = $Action
    total_plugins = 0
    errors = 0
    warnings = 0
    plugins = @()
}

if ($AsJson) {
    $result | ConvertTo-Json -Depth 5
} else {
    Write-Host "Plugin discovery action: $Action"
    Write-Host 'No public plugins are registered in this repo.'
}

exit 0
