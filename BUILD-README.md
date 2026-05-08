# Foundation Build Scripts

Reference para rebuild del installer. Los scripts de build están en el repo privado (`gentleman-foundation`).

## Prerequisites

| Tool | Purpose | Download |
|------|---------|----------|
| NSIS 3+ | Compile .exe installer | https://nsis.sourceforge.io/ |
| PowerShell 7+ | Script execution | Microsoft |

## Rebuild Process

1. Clonar repo privado: `gentleman-foundation`
2. Ejecutar `build\protect-foundation.ps1` para encriptar scripts
3. Ejecutar `build\create-installer.ps1` para compilar installer
4. Copiar `dist\Foundation-Setup.exe` a este repo público
5. Copiar `build\Foundation-Launcher.ps1` a este repo público

## Files in this Repo

| File | Purpose |
|------|---------|
| `Foundation-Setup.exe` | Installer compilado (274 KB, v2.8.0) |
| `Foundation-Launcher.ps1` | Smart launcher v2.0 con AES decryption + key fallback |
| `INSTALLATION.md` | Guía de instalación paso a paso |

## Encryption Format

Los scripts protegidos usan AES-256:
- **Key**: 32-byte random key (`keys/master.key`)
- **Format**: `Base64(IV[16 bytes] + encrypted_data)`
- **Decryption**: Raw AES (NO `ConvertTo-SecureString`)
