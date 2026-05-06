# Foundation - Public Distribution

> **Foundation Automation Framework** - Protected distribution for Windows.

## Quick Download & Install

### 1. Download Installer
Download `Foundation-Setup.exe` from this repository (see Releases or root folder).

### 2. Run Installer
Right-click `Foundation-Setup.exe` → **Run as Administrator**
- Installs to `C:\Program Files\Foundation\`
- Creates desktop and Start Menu shortcuts
- All components are encrypted (AES-256)

### 3. Launch Foundation
- Double-click desktop shortcut, or
- Start Menu → Foundation → Foundation
- Or run: `powershell -ExecutionPolicy Bypass -File "C:\Program Files\Foundation\Foundation-Launcher.ps1"`

## What's Inside

```
Foundation-Setup.exe contains:
├── Encrypted Scripts (185 files, .enc extension)
│   ├── scripts/utilities/*.ps1.enc
│   ├── config/*.json.enc
│   └── skills/*/SKILL.md.enc
├── Public Stubs (126 skills, no implementation)
├── Foundation-Launcher.ps1 (decrypts and runs)
└── Documentation (public only)
```

## Important Notes

- **Source code is NOT included** - All scripts are AES-256 encrypted
- **keys/master.key required** - Without it, scripts cannot be decrypted
- **Private repo**: https://github.com/EmmanuelOrtiz87/gentleman-foundation (requires access)
- This public repo contains only the installer and encrypted stubs

## Post-Installation

```powershell
# Open Foundation
cd "C:\Program Files\Foundation"
.\Foundation-Launcher.ps1

# Or use wf CLI (after installation)
wf verify        # Check stack health
wf daily-check   # Morning routine
wf status        # Context efficiency
```

## Requirements

- Windows 10/11 (64-bit)
- PowerShell 7+ 
- Administrator privileges (for installation)
- ~200MB disk space

## Troubleshooting

**Installer won't run?**
- Right-click → Properties → Unblock → Apply
- Run as Administrator

**"Cannot decrypt" error?**
- You need `keys/master.key` from the private repository
- Place it in `C:\Program Files\Foundation\keys\master.key`

## Links

- **Private Repo** (source): https://github.com/EmmanuelOrtiz87/gentleman-foundation
- **Issues**: https://github.com/EmmanuelOrtiz87/foundation-public/issues
- **Documentation**: `docs/` folder (public only)

---

**⚠️ This is a protected distribution. No source code included.**
