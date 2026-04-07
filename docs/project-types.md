# Project Types

The workspace foundation ships with a base project template plus lightweight overlays for common project shapes.

## Supported kinds

- `service`
- `cli`
- `library`

## Optional scaffold parameters

The scaffold can also capture a higher-level starting point through parameters:

- `preset`
- `architecture`
- `profile`

These do not replace `kind`; they add intent and defaults that can be refined later with the user or an AI helper.

## How it works

1. The bootstrap copies `templates/project-root/`.
2. If a matching overlay exists in `templates/project-types/<kind>/`, it is applied on top.
3. The overlay only replaces or adds files. It does not change the external tools.

## When to use each kind

- `service`: backend applications, APIs, workers, dashboards
- `cli`: command line tools, automation entrypoints, local utilities
- `library`: reusable packages or SDK-style codebases

## Extending

To add a new kind:

1. Create `templates/project-types/<kind>/`.
2. Add the files you want to override from the base template.
3. Add the kind to `projectKinds` in `config/workspace.config.json`.
