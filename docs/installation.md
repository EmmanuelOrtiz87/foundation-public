# Workspace Foundation Installation

This document explains the recommended order for setting up a new environment without coupling projects to the tools.

## Start Here

1. Install Git, PowerShell 7, and Go first.
2. Decide where the workspace root will live.
3. Install or expose external tools in `PATH`.
4. Run the workspace bootstrap.
5. Install the workspace skills so the standardized documentation and architecture workflows are available.
6. Create the first project using the scaffold.
7. Validate the workspace before adopting it in another project.
8. If the project uses AI assistance, record the chosen mode and provider in `docs/project-context.md` after scaffolding.

## Recommended Order

1. Git
2. PowerShell 7
3. Go
4. Workspace directory
5. External tools in `PATH`
6. Workspace skills
7. New project from template
8. Optional AI model setup
9. Defaults vs project decisions

## 1. Git

Install Git and verify it:

```powershell
git --version
```

## 2. PowerShell 7

Install PowerShell 7 and verify it:

```powershell
pwsh --version
```

## 3. Go

Install Go and verify it:

```powershell
go version
```

## 4. Workspace Directory

Recommended path:

```text
C:\Workspace_local
```

Use a stable directory for projects and sibling tools.

## 5. External Tools

Install the tools consumed by command, but keep them outside the project:

- `engram`
- `gga`
- `Gentleman-Skills` as a cloned skills repository

Verify each one with its help or version command.

### Portable Configuration

1. Leave `config/workspace.config.json` as-is if you want to start quickly.
2. If you prefer to adjust behavior before starting, copy `config/workspace.portable.example.json` over `config/workspace.config.json`.
3. Run `scripts/init-workspace.ps1` or `scripts/init-workspace.sh`.
4. Fill in the per-platform install commands if you want the bootstrap to execute them.
5. If you do not fill those commands, the bootstrap only validates and documents what is missing.
6. If you add a repository-backed resource tool, use `checkPath` instead of `checkCommand`.
7. On Windows, install Git Bash or WSL if you want `gga` to run its installer automatically.
8. The init automatically cleans runtime leftovers with `scripts/clean-runtime.ps1` or `scripts/clean-runtime.sh`.
9. If the project uses AI assistance, document the model decision in `docs/project-context.md` and follow `docs/ai-models.md`.
10. If you want to know what belongs to the kit versus the project itself, read `docs/defaults-vs-decisions.md`.

## 6. Workspace Skills

Install the reusable documentation and architecture skills into Codex so the standardized markdown and architecture workflows are available.

1. Keep the source skills in `skills/documentation-governance/` and `skills/architecture-governance/` inside this workspace kit.
2. Run `scripts/install-workspace-skills.ps1` or `scripts/install-workspace-skills.sh`.
3. Restart Codex after installation so the new skills are picked up.
4. Use the documentation skill when writing README files, technical docs, code reviews, setup guides, or script comments.
5. Use the architecture skill when choosing structure, defaults, compatibility rules, or decision records.

## 7. New Project

1. Copy `templates/project-root/` to a new directory.
2. Rename the project.
3. Complete `.env.example`.
4. Adjust `AGENTS.md`.
5. Run `scripts/new-project.ps1 -Name <project>` or `scripts/new-project.sh -Name <project>` if you want to use the local template.
6. Run `scripts/new-project.ps1 -Name <project> -RepoUrl <url>` or `scripts/new-project.sh -Name <project> -RepoUrl <url>` if you prefer cloning an existing repo.
7. Use `scripts/run-engram.ps1` or `scripts/run-engram.sh` to open Engram with isolated and auto-created `ENGRAM_DATA_DIR`.
8. If needed, pass `-AiModelMode`, `-AiModelProvider`, `-AiModelName`, `-AiModelEndpoint`, or `-AiModelNotes` to record the AI setup in the generated context file.
9. Run the local validation.

On Unix, use `scripts/validate-workspace.sh`.

If you want a quick view of the flow, run `scripts/help.ps1` or `scripts/help.sh`.

For a guide focused on new projects and reusing the flow in other repositories, see [docs/future-projects.md](future-projects.md).
