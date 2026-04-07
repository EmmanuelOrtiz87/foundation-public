$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$workspaceRoot = (Resolve-Path (Join-Path $root "..")).Path
$configPath = Join-Path $workspaceRoot 'config\workspace.config.json'
$fallbackPath = Join-Path $workspaceRoot 'config\workspace.portable.example.json'
$skillRoots = @(
    Join-Path $workspaceRoot 'skills\documentation-governance'
    Join-Path $workspaceRoot 'skills\architecture-governance'
)
$requiredScaffoldFiles = @(
    Join-Path $workspaceRoot 'templates\project-root\README.md'
    Join-Path $workspaceRoot 'templates\project-root\AGENTS.md'
    Join-Path $workspaceRoot 'templates\project-root\ARCHITECTURE.md'
    Join-Path $workspaceRoot 'templates\project-root\docs\setup\prerequisites.md'
    Join-Path $workspaceRoot 'templates\project-root\docs\project-context.md'
)

function Load-WorkspaceConfig {
    param([string]$Path)

    if (Test-Path $Path) {
        return Get-Content -Path $Path -Raw -Encoding UTF8 | ConvertFrom-Json
    }

    if (Test-Path $fallbackPath) {
        return Get-Content -Path $fallbackPath -Raw -Encoding UTF8 | ConvertFrom-Json
    }

    return [pscustomobject]@{ tools = @() }
}

function Test-ToolInstalled {
    param([pscustomobject]$Tool, [hashtable]$Context)

    if ($Tool.checkPath) {
        $path = $Tool.checkPath
        foreach ($key in $Context.Keys) {
            $path = $path.Replace("{$key}", [string]$Context[$key])
        }
        return Test-Path $path
    }

    if ($Tool.checkCommand) {
        return [bool](Get-Command $Tool.checkCommand -ErrorAction SilentlyContinue)
    }

    return $false
}

function Find-EmbeddedEngramState {
    param([string[]]$Roots)

    $hits = @()
    foreach ($root in $Roots) {
        if (-not (Test-Path -LiteralPath $root)) {
            continue
        }

        $match = Get-ChildItem -LiteralPath $root -Directory -Force -Recurse -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -eq '.engram' }

        if ($match) {
            $hits += $match.FullName
        }
    }

    return $hits
}

$config = Load-WorkspaceConfig -Path $configPath
$context = @{
    workspaceRoot = $workspaceRoot
    dataRoot = $(Join-Path $workspaceRoot '.engram-data')
    toolsRoot = $(Join-Path $workspaceRoot 'tools')
    projectsRoot = $(Join-Path $workspaceRoot 'projects')
}

foreach ($cmd in @('git', 'pwsh', 'go')) {
    if (Get-Command $cmd -ErrorAction SilentlyContinue) {
        Write-Host "$cmd OK"
    } else {
        Write-Warning "$cmd missing"
    }
}

foreach ($tool in $config.tools) {
    $toolName = $tool.name
    if ([string]::IsNullOrWhiteSpace($toolName)) {
        continue
    }

    $installed = Test-ToolInstalled -Tool $tool -Context $context
    if ($installed) {
        Write-Host "$toolName OK"
    } else {
        Write-Warning "$toolName missing"
    }

    if ($tool.requires) {
        foreach ($required in @($tool.requires)) {
            if (-not (Get-Command $required -ErrorAction SilentlyContinue)) {
                Write-Warning "$toolName requires $required"
            }
        }
    }
}

foreach ($skillRoot in $skillRoots) {
    if (-not (Test-Path -LiteralPath (Join-Path $skillRoot 'SKILL.md'))) {
        Write-Error "Skill is missing: $skillRoot\SKILL.md"
        exit 1
    }

    if (-not (Test-Path -LiteralPath (Join-Path $skillRoot 'agents\openai.yaml'))) {
        Write-Error "Skill metadata is missing: $skillRoot\agents\openai.yaml"
        exit 1
    }

    if (-not (Test-Path -LiteralPath (Join-Path $skillRoot 'references'))) {
        Write-Error "Skill references folder is missing: $skillRoot\references"
        exit 1
    }
}

foreach ($file in $requiredScaffoldFiles) {
    if (-not (Test-Path -LiteralPath $file)) {
        Write-Error "Required scaffold file is missing: $file"
        exit 1
    }
}

$workspaceParent = Split-Path -Parent $workspaceRoot
$embeddedHits = Find-EmbeddedEngramState -Roots @(
    (Join-Path $workspaceParent 'engram-tool'),
    (Join-Path $workspaceParent 'Engram\bitbucket-dashboard'),
    $context.projectsRoot
)

if ($embeddedHits.Count -gt 0) {
    Write-Error "Embedded Engram state found in:"
    foreach ($hit in $embeddedHits) {
        Write-Error "  $hit"
    }
    Write-Error "Run scripts/clean-runtime.ps1 before using Engram to keep repositories clean."
    exit 1
}

Write-Host "Workspace validation completed for $workspaceRoot"
