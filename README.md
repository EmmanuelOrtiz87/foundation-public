# Foundation - Public Distribution

> **Foundation Automation Framework** — Protected distribution for Windows.
> Launcher v2.0 | AES-256 | Sin popups de credenciales

## Quick Download

| Archivo | Tamaño | Descripción |
|---------|--------|-------------|
| `Foundation-Setup.exe` | 274 KB | Installer completo (scripts encriptados + launcher v2.0) |
| `Foundation-Launcher.ps1` | 37 KB | Smart launcher v2.0 (código fuente, referencia) |

> ⚠️ Ya no se distribuye `Foundation-Launcher.exe` — el installer usa `Foundation-Launcher.ps1` que se ejecuta con PowerShell.

## Install

1. Download `Foundation-Setup.exe`
2. Right-click → **Run as Administrator**
3. Get `keys/master.key` del repo privado (o pégalo al primer launch)
4. Ejecutar desde shortcut de desktop

```
C:\Program Files\Foundation\
├── protected/              # Scripts encriptados (.enc)
├── public/                 # Skill stubs
├── Foundation-Launcher.ps1 # Launcher v2.0
└── keys/
    └── master.key          # (tú provees esto)
```

## Requirements

- Windows 10/11 (64-bit)
- PowerShell 7+ (para `Foundation-Launcher.ps1`)
- Administrator privileges (instalación)
- `master.key` del repo privado

## Links

- **Private Repo** (source): https://github.com/EmmanuelOrtiz87/gentleman-foundation
- **Issues**: https://github.com/EmmanuelOrtiz87/foundation-public/issues
- **Installation Guide**: `INSTALLATION.md`
